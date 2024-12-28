package Starlight.movie;

import Starlight.admin.model.moviez;
import Starlight.admin.movieDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;


@WebServlet(name = "movieServ", urlPatterns = {"/userMovies"})
public class movieServ extends HttpServlet {
 
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        movieDao movieDAO = new movieDao();
        List<moviez> moviezList = movieDAO.getAllMovies(); // Assuming getAllMovies fetches movies
        
        request.setAttribute("moviez", moviezList); // Setting movies as an attribute in the request scope
        request.getRequestDispatcher("userMovies.jsp").forward(request, response); // Forward to the JSP page
    }
}
