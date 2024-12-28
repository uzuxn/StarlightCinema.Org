package Starlight.admin;

import Starlight.admin.model.moviez;
import Starlight.conn.connectionDB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class movieDao {

    // Method to get all movies
    public List<moviez> getAllMovies() {
        List<moviez> movies = new ArrayList<>();

        String query = "SELECT * FROM moviez";
        try (Connection conn = connectionDB.connect();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                moviez mv = new moviez();
                mv.setId(rs.getInt("id"));
                mv.setName(rs.getString("name"));
                mv.setRating(rs.getDouble("rating"));
                mv.setPosterUrl(rs.getString("poster_url"));
                mv.setDescription(rs.getString("description"));
                movies.add(mv);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return movies;
    }

    // Method to get a movie by ID
    public moviez getMovieById(int movieId) {
        moviez mv = null;

        String query = "SELECT * FROM moviez WHERE id = ?";

        try (Connection conn = connectionDB.connect();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, movieId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    mv = new moviez();
                    mv.setId(rs.getInt("id"));
                    mv.setName(rs.getString("name"));
                    mv.setRating(rs.getDouble("rating"));
                    mv.setPosterUrl(rs.getString("poster_url"));
                    mv.setDescription(rs.getString("description"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return mv;
    }

    public String getMovieNameById(int movieId) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
}
