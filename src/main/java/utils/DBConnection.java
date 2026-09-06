package utils;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	
    private static final String URL =
            "jdbc:mysql://localhost:3306/chat_app";

    private static final String USERNAME = "root";

    private static final String PASSWORD = "abdalah";
    
   
    public static Connection getConnection() throws SQLException {
    	
    	try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        return DriverManager.getConnection(
                URL,
                USERNAME,
                PASSWORD
        );
    }
}