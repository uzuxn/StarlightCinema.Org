
package Starlight.admin.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AdminMovieServ", urlPatterns = {"/AdminMovieServ"})
public class AdminMovieServ extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        // Common Parameters for Adding and Updating
        String name = request.getParameter("name");
        String rating = request.getParameter("rating");
        String posterUrl = request.getParameter("poster_url");
        String description = request.getParameter("description");

        // Get movie ID for update/delete
        String movieId = request.getParameter("movieId");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/starlightcinema", "root", "2797");

            if ("add".equals(action)) {
                // Add new movie
                PreparedStatement ps = con.prepareStatement(
                        "INSERT INTO moviez (name, rating, poster_url, description) VALUES (?, ?, ?, ?)");
                ps.setString(1, name);
                ps.setString(2, rating);
                ps.setString(3, posterUrl);
                ps.setString(4, description);
                ps.executeUpdate();

                response.sendRedirect("adminpanel.jsp?success=Movie added successfully");


            } else if ("delete".equals(action) && movieId != null) {
                // Delete movie by ID
                PreparedStatement ps = con.prepareStatement(
                        "DELETE FROM moviez WHERE id=?");
                ps.setString(1, movieId);
                ps.executeUpdate();

                response.sendRedirect("adminpanel.jsp?success=Movie deleted successfully");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminpanel.jsp?error=Error occurred while processing the movie");
        }
    }
}
