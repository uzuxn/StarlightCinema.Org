
package Starlight.admin.servlet;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "userServ", urlPatterns = {"/userServ"})
public class userServ extends HttpServlet {
    
    // Database connection setup
    private static final String DB_URL = "jdbc:mysql://localhost:3306/starlightcinema";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "2797";
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        // Common database connection setup
        try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            
            if ("add".equals(action)) {
                // Handle adding a new user
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String contactNumber = request.getParameter("contactNum");
                String dob = request.getParameter("dob");
                String gender = request.getParameter("gender");

                PreparedStatement ps = con.prepareStatement("INSERT INTO users (name, email, password, contactNum, dob, gender) VALUES (?, ?, ?, ?, ?, ?)");
                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, password);
                ps.setString(4, contactNumber);
                ps.setString(5, dob);
                ps.setString(6, gender);

                ps.executeUpdate();
                response.sendRedirect("adminpanel.jsp?success=User added successfully");

            } else if ("update".equals(action)) {
                // Handle updating a user
                String userId = request.getParameter("userId");
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String contactNumber = request.getParameter("contactNum");
                String dob = request.getParameter("dob");
                String gender = request.getParameter("gender");

                PreparedStatement ps = con.prepareStatement("UPDATE users SET name=?, email=?, password=?, contactNum=?, dob=?, gender=? WHERE userId=?");
                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, password);
                ps.setString(4, contactNumber);
                ps.setString(5, dob);
                ps.setString(6, gender);
                ps.setString(7, userId);

                ps.executeUpdate();
                response.sendRedirect("adminpanel.jsp?success=User updated successfully");

            } else if ("delete".equals(action)) {
                // Handle deleting a user
                String userId = request.getParameter("userId");

                PreparedStatement ps = con.prepareStatement("DELETE FROM users WHERE userId=?");
                ps.setString(1, userId);

                ps.executeUpdate();
                response.sendRedirect("adminpanel.jsp?success=User deleted successfully");

            } else {
                response.sendRedirect("adminpanel.jsp?error=Invalid action");
            }
        } catch (SQLException e) {
            response.sendRedirect("adminpanel.jsp?error=Database error occurred: " + e.getMessage());
        } catch (Exception e) {
            response.sendRedirect("adminpanel.jsp?error=Error occurred: " + e.getMessage());
        }
    }
}
