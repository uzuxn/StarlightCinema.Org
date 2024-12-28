
package Starlight.user.servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.*;

@WebServlet("/user/reservationServlet")
public class reservationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database connection details
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/starlightcinema";
    private static final String DB_USER = "root"; 
    private static final String DB_PASSWORD = "2797"; 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve form data
        String movieId = request.getParameter("movieId");
        String seatCount = request.getParameter("seatCount");
        String totalPrice = request.getParameter("totalAmt");

        // Retrieve the user's name from the session
        HttpSession session = request.getSession();
        String userName = (String) session.getAttribute("user");

        if (userName == null || userName.trim().isEmpty()) {
            response.sendRedirect("Userlogin.jsp"); // Redirect to login if the user is not logged in
            return;
        }

        if (movieId == null || seatCount == null || totalPrice == null || 
            movieId.trim().isEmpty() || seatCount.trim().isEmpty() || totalPrice.trim().isEmpty()) {
            response.sendRedirect("error.jsp");
            return;
        }

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // Fetch movie details from the database
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);

            String query = "SELECT name FROM moviez WHERE id = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, Integer.parseInt(movieId));
            rs = pstmt.executeQuery();

            String movieName = "";
            if (rs.next()) {
                movieName = rs.getString("name");
            } else {
                response.sendRedirect("error.jsp");
                return;
            }

            // Set attributes to forward to checkout page
            request.setAttribute("userName", userName); // Include user's name
            request.setAttribute("movieName", movieName);
            request.setAttribute("seatCount", seatCount);
            request.setAttribute("totalPrice", totalPrice);

            request.getRequestDispatcher("checkout.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        } finally {
            // Close resources
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException ignored) {
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}

