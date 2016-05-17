import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Test {
	public static void main(String[] args) throws ClassNotFoundException { 
        Connection conn = null;
        Statement st = null;
        ResultSet rs = null;
        
        String login = "login2";
        String haslo = "password";
        String rodzaj_uzytkownika = "domyślny";
        String organizacja = "org";
        String imie = "Maciej";
        String nazwisko = "Mieszczyński";
        
        String query = "{call dodajUzytkownika(?, ?, ?, ?, ?, ?)}";
        
        //String url = "jdbc:mysql://localhost:3306/db?autoReconnect=true&useSSL=false";
        String url = "jdbc:mysql://localhost:3306/db?user=root&password=localhost&useSSL=false&sessionVariables=sql_mode='NO_ENGINE_SUBSTITUTION'";
        String user = "root";
        String password = "localhost";
        
        try {
        	
        	Class.forName("com.mysql.jdbc.Driver");
        	//conn = DriverManager.getConnection(url, user, password);
        	conn = DriverManager.getConnection(url);
        	if (conn != null) {
                System.out.println("Connected to the database db");
            }
        	
        	CallableStatement stmt = conn.prepareCall(query);
        	stmt.setString(1, login);
			stmt.setString(2, haslo);
			stmt.setString(3, rodzaj_uzytkownika);
			stmt.setString(4, organizacja);
			stmt.setString(5, imie);
			stmt.setString(6, nazwisko);
        	
			rs = stmt.executeQuery();
			
        	//conn.setAutoCommit(false);
            //st = conn.createStatement();
        } catch (SQLException ex) {
        	System.out.println(ex.getMessage());
        }
}
}
