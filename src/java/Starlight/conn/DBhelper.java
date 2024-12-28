
package Starlight.conn;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;



public class DBhelper {

    // Method to get user contact number by email
    public static String getUserContactByEmail(String email) {
        String contactNumber = null;

        try (Connection conn = connectionDB.connect();
             PreparedStatement stmt = conn.prepareStatement("SELECT contactNum FROM users WHERE email = ?")) {

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                contactNumber = rs.getString("contactNum");
            }
        } catch (Exception e) {
            System.err.println("Error fetching user contact: " + e.getMessage());
        }

        return contactNumber;
    }
}
