
package Starlight.admin.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/reportServ")
public class reportServ extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Connect to database
            System.out.println("Connecting to database...");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/starlightcinema", "root", "2797");
            System.out.println("Database connection successful!");

            // Prepare the SQL query to fetch report data
            String query = "SELECT m.id AS movieId, m.name AS movieName, COUNT(s.showtimesId) AS showtimesCount, " +
                           "       r.userName, u.name AS userName, COUNT(r.id) AS reservationCount " +
                           "FROM moviez m " +
                           "LEFT JOIN showtimes s ON m.id = s.movieId " +
                           "LEFT JOIN reservations r ON s.showtimesId = r.movieId " +
                           "LEFT JOIN users u ON r.userName = u.name " + // Join on userName instead of userId
                           "GROUP BY m.id, r.userName ORDER BY showtimesCount DESC";

            // Execute the query
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(query);

            // Generate the report in HTML format
            StringBuilder report = new StringBuilder();
            report.append("<h2>Movie & Reservation Analysis Report</h2>");
            report.append("<table border='1'>");  // Added border for better visibility
            report.append("<tr><th>Movie ID</th><th>Movie Title</th><th>Showtimes Count</th><th>User Name</th><th>Reservation Count</th></tr>");

            // Iterate through the result set and build the report table
            while (rs.next()) {
                int movieId = rs.getInt("movieId");  // Corrected column name to match the table structure
                String movieTitle = rs.getString("movieName");  // Corrected column name
                int showtimesCount = rs.getInt("showtimesCount");
                String userName = rs.getString("userName");  // Corrected column name for username
                int reservationCount = rs.getInt("reservationCount");

                report.append("<tr><td>").append(movieId)
                      .append("</td><td>").append(movieTitle)
                      .append("</td><td>").append(showtimesCount)
                      .append("</td><td>").append(userName)
                      .append("</td><td>").append(reservationCount)
                      .append("</td></tr>");
            }

            report.append("</table>");

            // Add the report content to the request to display on the frontend
            request.setAttribute("reportContent", report.toString());
            // Forward to the admin panel to display the report
            request.getRequestDispatcher("adminpanel.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();  // Log detailed error
            response.sendRedirect("adminpanel.jsp?error=Error occurred while generating the report: " + e.getMessage());
        }
    }
}
