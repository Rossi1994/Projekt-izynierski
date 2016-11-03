from flask import Flask, render_template, request, json, session, redirect
from flask.ext.mysql import MySQL
#from werkzeug import generate_password_hash, check_password_hash

mysql = MySQL()
app = Flask(__name__)
app.secret_key = 'sekret'
 
# MySQL configurations
app.config['MYSQL_DATABASE_USER'] = 'root'
#app.config['MYSQL_DATABASE_USER'] = 'Micik'
app.config['MYSQL_DATABASE_PASSWORD'] = 'localhost'
app.config['MYSQL_DATABASE_DB'] = 'db'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
mysql.init_app(app)


@app.route("/")
def main():
    return render_template('index.html')
    
@app.route('/showSignUp')
def showSignUp():
    return render_template('signup.html')
    
@app.route('/showSignIn')
def showSignIn():
    return render_template('signin.html')
    
@app.route('/signUp',methods=['POST','GET'])
def signUp():
    try:
        _name = request.form['inputName']
        _surname = request.form['inputSurname']
        _password = request.form['inputPassword']
        _email = request.form['inputEmail']
        _type = request.form['inputType']
        _organization = request.form['inputOrganization']

        # validate the received values
        if _name and _surname and _password and _email and _type and _organization:
            
            # All Good, let's call MySQL
            
            conn = mysql.connect()
            cursor = conn.cursor()
            #_hashed_password = generate_password_hash(_password)
            #cursor.callproc('rejestracja4',(_name,_email,_hashed_password))
            #cursor.callproc('rejestracja4',(_name,_email,_password))
            
            cursor.callproc('dodajUzytkownika', (_email, _password, _type, _organization, _name, _surname))
            data = cursor.fetchall()

            if len(data) is 0:
                conn.commit()
                return json.dumps({'message':'User created successfully !'})
            else:
                return json.dumps({'error':str(data[0])})
        else:
            return json.dumps({'html':'<span>Enter the required fields</span>'})

    except Exception as e:
        return json.dumps({'error':str(e)})
    finally:
        cursor.close() 
        conn.close()    
        
@app.route('/validateLogin',methods=['POST'])
def validateLogin():
    try:
        _username = request.form['inputEmail']
        _password = request.form['inputPassword']
        
        con = mysql.connect()
        cursor = con.cursor()
        cursor.callproc('logowanie',(_username,))
        data = cursor.fetchall()
        
        if len(data) > 0:
            #if check_password_hash(str(data[0][3]),_password):
            if str(data[0][3]) == _password:
                session['user'] = data[0][0]
                return redirect('/userHome')
            else:
                return render_template('error.html',error = 'Zly email lub haslo!')
        else:
            return render_template('error.html',error = 'Zly email lub haslo!')
 
    except Exception as e:
        return render_template('error.html',error = str(e))
    finally:
        cursor.close()
        con.close()

@app.route('/userHome')
def userHome():
    if session.get('user'):
        return render_template('userHome.html')
    else:
        return render_template('error.html',error = 'Nieautoryzowany dostep!')
        
@app.route('/logout')
def logout():
    session.pop('user',None)
    return redirect('/')
    
@app.route('/newSheet', methods=['POST','GET'])
def newSheet():
    try:
        _sheet_name = request.form['inputSheetName']
        _number_items = request.form['inputItems']
        _number_operators = request.form['inputOperators']
        _number_chars = request.form['inputChars']
        _number_trials = request.form['inputTrials']
        
        if _sheet_name and _number_items and _number_operators and _number_chars and _number_trials:
            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.callproc('nowyArkusz',(_sheet_name, _number_items,_number_operators,_number_chars, _number_trials))
            data = cursor.fetchall()
            
            if len(data) is 0:
                conn.commit()
                return redirect('/sheet')
                #return json.dumps({'message':'Arkusz stworzono poprawnie!'})
            else:
                return json.dumps({'error':str(data[0])})
        else:
            return json.dumps({'html':'<span>Enter the required fields</span>'})
    except Exception as e:
        return json.dumps({'error':str(e)})
    finally:
        cursor.close() 
        conn.close()
    #return render_template('newSheet.html')
    
@app.route('/sheet', methods=['POST'])
def sheet():
    return render_template('sheet.html')
        

if __name__ == "__main__":
    #app.run(port=5002)
    app.run(host='0.0.0.0')