
package Starlight.admin.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.Locale;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "showtimeServ")
public class showtimeServ extends HttpServlet {


@Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    String action = request.getParameter("action");
    String showtimesId = request.getParameter("showtimesId");  // Showtimes ID for deletion
    String movieId = request.getParameter("movieId");
    String showDate = request.getParameter("showDate"); 
    String showTime = request.getParameter("showTime");

    try {
        // Log raw inputs
        System.out.println("Action: " + action);
        System.out.println("Raw showtimesId: " + showtimesId);

        // Validate date and time formats for 'add' or 'update' actions, not needed for 'delete'
        if ("add".equals(action) || "update".equals(action)) {
            if (showDate == null || !showDate.matches("\\d{4}/\\d{2}/\\d{2}")) {
                response.sendRedirect("adminpanel.jsp?error=Invalid date format: " + showDate);
                return;
            }
            if (showTime == null || !showTime.matches("\\d{2}:\\d{2}:\\d{2}")) {
                response.sendRedirect("adminpanel.jsp?error=Invalid time format: " + showTime);
                return;
            }
        }

        // Database operations
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/starlightcinema", "root", "2797");

        if ("add".equals(action)) {
            // Handle 'add' logic
            String formattedDate = showDate.replaceAll("/", "-");
            java.sql.Time sqlTime = java.sql.Time.valueOf(showTime);
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO showtimes (movieId, showDate, showTime) VALUES (?, ?, ?)");
            ps.setInt(1, Integer.parseInt(movieId));
            ps.setDate(2, java.sql.Date.valueOf(formattedDate));
            ps.setTime(3, sqlTime);
            ps.executeUpdate();
            response.sendRedirect("adminpanel.jsp?success=Showtime added successfully");

        } else if ("update".equals(action) && showtimesId != null && !showtimesId.isEmpty()) {
            // Handle 'update' logic
            String formattedDate = showDate.replaceAll("/", "-");
            java.sql.Time sqlTime = java.sql.Time.valueOf(showTime);
            PreparedStatement ps = con.prepareStatement(
                    "UPDATE showtimes SET movieId=?, showDate=?, showTime=? WHERE showtimesId=?");
            ps.setInt(1, Integer.parseInt(movieId));
            ps.setDate(2, java.sql.Date.valueOf(formattedDate));
            ps.setTime(3, sqlTime);
            ps.setInt(4, Integer.parseInt(showtimesId));
            ps.executeUpdate();
            response.sendRedirect("adminpanel.jsp?success=Showtime updated successfully");

        } else if ("delete".equals(action) && showtimesId != null && !showtimesId.isEmpty()) {
            // Handle 'delete' logic
            PreparedStatement ps = con.prepareStatement(
                    "DELETE FROM showtimes WHERE showtimesId=?");
            ps.setInt(1, Integer.parseInt(showtimesId));
            ps.executeUpdate();
            response.sendRedirect("adminpanel.jsp?success=Showtime deleted successfully");

        } else {
            response.sendRedirect("adminpanel.jsp?error=Invalid action or missing parameters");
        }

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("adminpanel.jsp?error=Error occurred: " + e.getMessage());
    }
}

}
