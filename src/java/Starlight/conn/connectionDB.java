package Starlight.conn;

import java.sql.Connection;
import java.sql.DriverManager;

public class connectionDB {
    public static Connection connect() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/starlightcinema", "root", "2797");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }

    public static Connection getConnection() {
        throw new UnsupportedOperationException("Not supported yet."); 
    }
}
