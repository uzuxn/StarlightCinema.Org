
package Starlight.admin.services;

import java.sql.*;
import java.util.*;
import Starlight.conn.connectionDB;
import Starlight.admin.model.moviez;

public class adminService {
    public List<moviez> getAllMovies() {
        List<moviez> movies = new ArrayList<>();
        try {
            Connection conn = connectionDB.connect();
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM moviez");
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                moviez Movie = new moviez(); // Fixed: Class name is "Movie"
                Movie.setId(rs.getInt("id"));
                Movie.setName(rs.getString("name"));
                Movie.setPosterUrl(rs.getString("posterUrl"));
                Movie.setRating(rs.getDouble("rating"));
                Movie.setDescription(rs.getString("description"));
                
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return movies;
    }
}
