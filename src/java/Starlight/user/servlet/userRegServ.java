
package Starlight.user.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import Starlight.conn.connectionDB;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@WebServlet("/userRegServ")
public class userRegServ extends HttpServlet {
    private static final Logger logger = LoggerFactory.getLogger(userRegServ.class);

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form parameters
        String name = request.getParameter("Name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String contactNumber = request.getParameter("contact_number");
        String dob = request.getParameter("dob");
        String gender = request.getParameter("gender");

        Connection conn = null;

        try {
            // Establish database connection
            conn = connectionDB.connect();
            if (conn == null) {
                logger.error("Failed to establish database connection.");
                response.sendRedirect("registerError.jsp");
                return;
            }

            // Begin transaction
            conn.setAutoCommit(false);

            // Hash password (simple hashing here, replace with better algorithm in production)
            String hashedPassword = hashPassword(password);

            // Insert user into the database
            String insertSQL = "INSERT INTO users (name, email, password, contactNum, dob, gender) VALUES (?, ?, ?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(insertSQL)) {
                stmt.setString(1, name);
                stmt.setString(2, email);
                stmt.setString(3, hashedPassword);
                stmt.setString(4, contactNumber);
                stmt.setString(5, dob);
                stmt.setString(6, gender);

                int rowsAffected = stmt.executeUpdate();

                if (rowsAffected > 0) {
                    conn.commit();
                    logger.info("Registration successful.");
                    response.setContentType("text/html");
                    response.getWriter().println("<script type='text/javascript'>");
                    response.getWriter().println("alert('Registration successful!');");
                    response.getWriter().println("window.location.href='Userlogin.jsp';");
                    response.getWriter().println("</script>");
                } else {
                    conn.rollback();
                    logger.error("Registration failed. Transaction rolled back.");
                    response.sendRedirect("registerError.jsp");
                }
            } catch (SQLException e) {
                conn.rollback();
                logger.error("Error inserting user into database: ", e);
                response.sendRedirect("registerError.jsp");
            }

        } catch (Exception e) {
            logger.error("Exception during registration process: ", e);
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException rollbackEx) {
                    logger.error("Failed to rollback transaction: ", rollbackEx);
                }
            }
            response.sendRedirect("registerError.jsp");
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                    logger.info("Database connection closed.");
                } catch (SQLException ex) {
                    logger.error("Error closing connection: ", ex);
                }
            }
        }
    }

    private String hashPassword(String password) {
        
        return Integer.toHexString(password.hashCode());
    }
}
