/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Starlight.admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import Starlight.conn.connectionDB;

/**
 *
 * @author Uzman Fairoos
 */
public class UserDAO {
    public boolean addUser(String name,String email,String password,String contactNumber,String dob,String gender){
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try{
            conn = connectionDB.getConnection();
            String sql = "INSERT INTO users (name, email, password, contactNum, dob, gender) VALUES (?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);

            // Step 3: Set parameters
            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, password);
            stmt.setString(4, contactNumber);
            stmt.setString(5, dob);
            stmt.setString(6, gender);
            
            int rows = stmt.executeUpdate();
            
            return rows > 0;
        }
        catch(Exception e){
            e.printStackTrace();
            return false;
        }
    }
}
