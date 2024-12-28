
package Starlight.user.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class PaySucServ extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String transactionId = request.getParameter("transactionId");
        
        // Save transaction ID and update reservation status in your database
        // (Implement your database logic here)

        response.sendRedirect("success.jsp?transactionId=" + transactionId);
    }
}
