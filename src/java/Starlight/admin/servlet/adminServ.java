
package Starlight.admin.servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.*;

@WebServlet(name = "adminServ", urlPatterns = {"/adminServ"})
public class adminServ extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action"); // Determine whether it's add, update, or delete
        String name = request.getParameter("name");
        String dob = request.getParameter("dob");
        String gender = request.getParameter("gender");
        String role = request.getParameter("role");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String adminId = request.getParameter("adminId");  // For update and delete actions

        Connection con = null;
        PreparedStatement ps = null;
        String message = "";

        try {
            // Connect to the database
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/starlightcinema", "root", "2797");

            if ("add".equalsIgnoreCase(action)) {
                // Add new Admin
                ps = con.prepareStatement("INSERT INTO admin (name, dob, gender, role, email, password) VALUES (?, ?, ?, ?, ?, ?)");
                ps.setString(1, name);
                ps.setString(2, dob);
                ps.setString(3, gender);
                ps.setString(4, role);
                ps.setString(5, email);
                ps.setString(6, password);
                ps.executeUpdate();
                message = "Admin added successfully!";
            } else if ("update".equalsIgnoreCase(action)) {
                // Update Admin details
                ps = con.prepareStatement("UPDATE admin SET name = ?, dob = ?, gender = ?, role = ?, email = ?, password = ? WHERE adminId = ?");
                ps.setString(1, name);
                ps.setString(2, dob);
                ps.setString(3, gender);
                ps.setString(4, role);
                ps.setString(5, email);
                ps.setString(6, password);
                ps.setString(7, adminId);
                ps.executeUpdate();
                message = "Admin updated successfully!";
            } else if ("delete".equalsIgnoreCase(action)) {
                // Delete Admin
                ps = con.prepareStatement("DELETE FROM admin WHERE adminId = ?");
                ps.setString(1, adminId);
                ps.executeUpdate();
                message = "Admin deleted successfully!";
            }

            // Redirect with success message
            response.sendRedirect("adminpanel.jsp?success=" + message);

        } catch (Exception e) {
            // Redirect with error message if any exception occurs
            message = "Error occurred: " + e.getMessage();
            response.sendRedirect("adminpanel.jsp?error=" + message);
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
