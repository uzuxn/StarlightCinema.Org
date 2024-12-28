
package Starlight.user.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class ReservCancelServ extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/starlightcinema";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "2797";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // Get the reservation ID from the request
        String reservationId = request.getParameter("reservationId");

        // Validate the reservation ID
        if (reservationId == null || reservationId.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid reservation ID.");
            return;
        }

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            // Connect to the database
            Class.forName("com.mysql.cj.jdbc.Driver"); // Ensure you have the MySQL JDBC driver
            connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // SQL query to delete the reservation
            String sql = "DELETE FROM reservations WHERE reservation_id = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, reservationId);

            // Execute the query
            int rowsAffected = preparedStatement.executeUpdate();

            if (rowsAffected > 0) {
                // Redirect to a success page
                response.sendRedirect("reservationCancelled.jsp");
            } else {
                // Handle cases where the reservation ID doesn't exist
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Reservation not found.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing your request.");
        } finally {
            // Close resources
            try {
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
