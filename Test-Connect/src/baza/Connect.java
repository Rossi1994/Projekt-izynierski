package baza;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.ResultSet;

public class Connect {
	public static void main(String[] args) {

        Connection conn = null;
        Statement st = null;
        ResultSet rs = null;

        //String url = "jdbc:mysql://localhost:3306/db";
        String url = "jdbc:mysql://localhost:3306/Peoples?autoReconnect=true&useSSL=false";
        String user = "root";
        String password = "localhost";
        
        try {
        	Class.forName("com.mysql.jdbc.Driver");

            //conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/?user=root&password=localhost");
        	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db?useSSL=false", "root", "localhost");
        	if (conn != null) {
                System.out.println("Connected to the database db");
            }
            
            conn.setAutoCommit(false);
            st = conn.createStatement();
            
            //Testowe zapytanie
            rs = st.executeQuery("SELECT login FROM UZYTKOWNICY");
            //st.addBatch("DELETE FROM ...");

            while (rs.next()) {
            	String lastLogin = rs.getString("login");
            	System.out.println(lastLogin + "\n");
            }
            
            conn.close();
        } catch(SQLException ex) {
        	System.err.println("Got an exception! ");
            ex.printStackTrace();
        } catch(ClassNotFoundException e) {
        	e.printStackTrace();
        }
	}
}
