package Starlight.admin.servlet;

import java.io.*;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/adminLoginServ")
public class adminLoginServ extends HttpServlet {
    // Database connection credentials
    private static final String DB_URL = "jdbc:mysql://localhost:3306/starlightcinema";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "2797";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve form data
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Initialize JDBC variables
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // Step 1: Load JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Step 2: Establish a connection
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Step 3: Create SQL query
            String sql = "SELECT * FROM admin WHERE email = ? AND password = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            pstmt.setString(2, password);

            // Step 4: Execute query
            rs = pstmt.executeQuery();

            if (rs.next()) {
                // Successful login, set session attributes
                HttpSession session = request.getSession();
                session.setAttribute("adminid", rs.getInt("adminid"));
                session.setAttribute("name", rs.getString("name"));
                session.setAttribute("role", rs.getString("role"));

                // Redirect to admin panel
                response.sendRedirect("adminpanel.jsp");
            } else {
                // Failed login, send back to login page with an alert
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Invalid email or password!');");
                out.println("window.location.href = 'adminlogin.jsp';");
                out.println("</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<h3>Database Connection Error: " + e.getMessage() + "</h3>");
        } finally {
            // Step 5: Close resources
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
