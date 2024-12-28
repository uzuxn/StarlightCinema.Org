//package Starlight.user.servlet;
//
//import Starlight.user.services.SMSService;
//import Starlight.user.services.userService;
//import java.io.IOException;
//import java.io.PrintWriter;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//
//
//@WebServlet(name = "SMSserv", urlPatterns = {"/SMSserv"})
//public class SMSserv extends HttpServlet {
//
//
//
//    private final userService userService = new userService();
//    private final SMSService smsService = new SMSService();
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        String userId = request.getParameter("userId");
//        String messageType = request.getParameter("messageType");
//
//        // Fetch user contact number
//        String contactNumber = userService.getUserContact(userId);
//        if (contactNumber == null) {
//            response.getWriter().write("Failed to fetch contact number.");
//            return;
//        }
//
//        // Prepare the message
//        String message;
//        if ("registration".equals(messageType)) {
//            message = "Thank you for registering with StarlightCinema!";
//        } else if ("reservation".equals(messageType)) {
//            message = "Your reservation has been successfully made. Enjoy your movie!";
//        } else {
//            response.getWriter().write("Invalid message type.");
//            return;
//        }
//
//        // Send the SMS
//        boolean isSent = smsService.sendSms(message, contactNumber);
//        response.getWriter().write(isSent ? "SMS sent successfully!" : "Failed to send SMS.");
//    }
//}
//
