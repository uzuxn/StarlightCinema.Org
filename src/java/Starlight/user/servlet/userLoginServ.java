
package Starlight.user.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/userLoginServ")
public class userLoginServ extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database credentials
    private static final String DB_URL = "jdbc:mysql://localhost:3306/starlightcinema";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "2797";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Retrieve form data
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // SQL query to validate credentials and retrieve user name
        String sql = "SELECT name FROM users WHERE email = ? AND password = ?";

        try {
            // Load JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish database connection
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Prepare SQL statement
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, email);
            pst.setString(2, password);

            // Execute query
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                // Login successful - retrieve the user name
                String username = rs.getString("name");

                // Set session attribute
                HttpSession session = request.getSession();
                session.setAttribute("user", username); // Store username in session

                // Redirect to movies page
                response.sendRedirect("userMovies.jsp");

            } else {
                // Invalid credentials
                response.sendRedirect("loginerror.jsp");
            }

            // Close resources
            rs.close();
            pst.close();
            conn.close();

        } catch (Exception e) {
            out.println("<h1>Error:</h1>");
            out.println("<p>" + e.getMessage() + "</p>");
            e.printStackTrace();
        }
    }
}

