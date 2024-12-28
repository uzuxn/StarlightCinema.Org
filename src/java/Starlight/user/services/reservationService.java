package Starlight.user.services;

import Starlight.conn.connectionDB;
import Starlight.user.model.reservation;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class reservationService {
    public boolean makeReservation(reservation reservation) {
        try {
            Connection conn = connectionDB.connect();
            String sql = "INSERT INTO reservations (movie_id, user_id, seats) VALUES (?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, reservation.getMovieId());
            ps.setInt(2, reservation.getUserId());
            ps.setInt(3, reservation.getSeats());
            
            int rows = ps.executeUpdate();
            conn.close();
            return rows > 0; // Reservation successful
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
