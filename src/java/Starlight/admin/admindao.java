package Starlight.admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import Starlight.conn.connectionDB;

public class admindao {
    private Connection conn;

    // Constructor to initialize database connection
    public admindao() {
        conn = connectionDB.getConnection();
    }

    // Verify admin credentials
    public boolean verifyAdmin(String email, String password) {
        boolean status = false;
        String query = "SELECT * FROM admin WHERE email = ? AND password = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                status = true; // Admin found
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }
}
