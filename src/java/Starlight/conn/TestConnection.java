package Starlight.conn;

import java.sql.Connection;

public class TestConnection {
    public static void main(String[] args) {
        // Call the connect() method to establish a connection
        Connection conn = connectionDB.connect();

        if (conn != null) {
            System.out.println("Database connected successfully!");
        } else {
            System.out.println("Failed to connect to the database.");
        }
    }
}
