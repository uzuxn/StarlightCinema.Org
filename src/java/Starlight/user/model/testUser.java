/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Starlight.user.model;

/**
 *
 * @author Uzman Fairoos
 */
public class testUser {
    public static void main(String[] args) {
        // Create user object
        user newUser = new user(1, "John Doe", "john@example.com", "securePassword", 
                                "1234567890", "1995-05-15", "Male");
        
        // Print user details
        System.out.println(newUser.toString());
    }
}
   
