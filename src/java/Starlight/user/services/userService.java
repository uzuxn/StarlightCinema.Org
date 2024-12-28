package Starlight.user.services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import Starlight.conn.connectionDB;

public class userService {

    public String getUserContact(String userId) {
        String contactNumber = null;
        String query = "SELECT contactNum FROM user WHERE user_id = ?";
        try (Connection conn = connectionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    contactNumber = rs.getString("contactNum");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return contactNumber;
    }
}
