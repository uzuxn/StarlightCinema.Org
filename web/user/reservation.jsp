<%--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.util.*" %>
<%
    // Fetch movie ID passed via URL
    String movieId = request.getParameter("movieId");

    if (movieId == null || movieId.trim().isEmpty()) {
        out.println("<h1>Error: Movie ID is missing.</h1>");
        return;
    }

    // Database connection setup
    String jdbcURL = "jdbc:mysql://localhost:3306/starlightcinema";
    String dbUser = "root"; // replace with your DB username
    String dbPassword = "2797"; // replace with your DB password
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    String movieName = "", moviePoster = "", movieDescription = "", movieRating = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

        // Query movie details
        String query = "SELECT name, poster_url, description, rating FROM moviez WHERE id = ?";
        stmt = conn.prepareStatement(query);
        stmt.setInt(1, Integer.parseInt(movieId));
        rs = stmt.executeQuery();

        if (rs.next()) {
            movieName = rs.getString("name");
            moviePoster = rs.getString("poster_url");
            movieDescription = rs.getString("description");
            movieRating = rs.getString("rating");
        } else {
            response.sendRedirect("error.jsp");
            return;
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("error.jsp");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
    }
%>--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.util.*" %>
<%
    // Fetch the logged-in user's name from the session
    String userName = (String) session.getAttribute("user");

    if (userName == null || userName.trim().isEmpty()) {
        response.sendRedirect("login.jsp"); // Redirect to login if no user is logged in
        return;
    }

    // Fetch movie ID passed via URL
    String movieId = request.getParameter("movieId");

    if (movieId == null || movieId.trim().isEmpty()) {
        out.println("<h1>Error: Movie ID is missing.</h1>");
        return;
    }

    // Database connection setup
    String jdbcURL = "jdbc:mysql://localhost:3306/starlightcinema";
    String dbUser = "root"; // replace with your DB username
    String dbPassword = "2797"; // replace with your DB password
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    String movieName = "", moviePoster = "", movieDescription = "", movieRating = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

        // Query movie details
        String query = "SELECT name, poster_url, description, rating FROM moviez WHERE id = ?";
        stmt = conn.prepareStatement(query);
        stmt.setInt(1, Integer.parseInt(movieId));
        rs = stmt.executeQuery();

        if (rs.next()) {
            movieName = rs.getString("name");
            moviePoster = rs.getString("poster_url");
            movieDescription = rs.getString("description");
            movieRating = rs.getString("rating");
        } else {
            response.sendRedirect("error.jsp");
            return;
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("error.jsp");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <title>Reserve Your Seats</title>
<style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #202938;
            color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 800px;
            margin: 40px auto;
            background: #202938;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
        }
        header {
            background: #2a2f36;
            text-align: center;
            padding: 20px;
            font-size: 1.5em;
            font-weight: bold;
            color: #fff;
        }
        .movie-details {
            padding: 20px;
            text-align: center;
        }
        .movie-details img {
            width: 100%;
            max-height: 300px;
            object-fit: cover;
            margin-top: 10px;
            border-radius: 8px;
        }
        .movie-details h2 {
            margin: 10px 0;
            color: #f4f4f4;
        }
        .movie-details p {
            margin: 5px 0;
            color: #b3b3b3;
        }
        .seat-selection {
            padding: 20px;
            text-align: center;
        }
        .seats {
            display: grid;
            grid-template-columns: repeat(5, 1fr);
            gap: 10px;
            justify-content: center;
        }
        .seat {
            padding: 15px;
            background: #444;
            color: #fff;
            border: none;
            border-radius: 5px;
            font-size: 1em;
            cursor: pointer;
            transition: 0.3s;
        }
        .seat:hover {
            background: #666;
        }
        .seat.selected {
            background: #28a745;
        }
        .checkout {
            padding: 20px;
            text-align: center;
            background: #222;
            color: #f4f4f4;
        }
        .checkout button {
            padding: 10px 20px;
            font-size: 1em;
            background: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: 0.3s;
        }
        .checkout button:hover {
            background: #0056b3;
        }
    </style>
</head>
<body class="bg-gray-900 text-white">
    <div class="container">
         <header>
            Reserve Your Seats
            <p>Welcome, <strong><%= userName %></strong>!</p>
        </header>
        

        <!-- Movie Details Section -->
        <div class="movie-details">
            <h2><%= movieName %></h2>
            <p><strong>Rating:</strong> <%= movieRating %></p>
            <p><strong>Description:</strong> <%= movieDescription %></p>
            <img src="<%= moviePoster %>" alt="Movie Poster">
        </div>

        <!-- Seat Selection Section -->
        <div class="seat-selection">
            <h3>Choose Your Seats</h3>
            <div class="seats">
                <% for (char row = 'A'; row <= 'B'; row++) { %>
                    <% for (int seat = 1; seat <= 5; seat++) { %>
                        <button class="seat"><%= row + seat %></button>
                    <% } %>
                <% } %>
            </div>
        </div>

        <!-- Checkout Section -->
        <div class="checkout">
            <p>Total Price: $<span id="totalPrice">0</span></p>
            <form action="reservationServlet" method="post">
                <input type="hidden" name="movieId" value="<%= movieId %>">
                <input type="hidden" name="userName" value="<%= userName %>">
                <input type="hidden" name="seatCount" id="seatCount" value="">
                <input type="hidden" name="totalAmt" id="totalAmt" value="">
                <button type="submit" class="checkout-btn">Confirm and Checkout</button>
            </form>

        </div>
    </div>

    <script>
        const seatButtons = document.querySelectorAll('.seat');
        const totalPriceElement = document.getElementById('totalPrice');
        const seatCountInput = document.getElementById('seatCount');
        const totalAmtInput = document.getElementById('totalAmt');
        const seatPrice = 10; // Price per seat

        let selectedSeats = [];
        let totalPrice = 0;

        seatButtons.forEach(seat => {
            seat.addEventListener('click', () => {
                const seatNumber = seat.textContent;

                if (selectedSeats.includes(seatNumber)) {
                    selectedSeats = selectedSeats.filter(s => s !== seatNumber);
                    totalPrice -= seatPrice;
                    seat.classList.remove('selected');
                } else {
                    selectedSeats.push(seatNumber);
                    totalPrice += seatPrice;
                    seat.classList.add('selected');
                }

                totalPriceElement.textContent = totalPrice;
                seatCountInput.value = selectedSeats.join(',');
                totalAmtInput.value = totalPrice;
            });
        });
    </script>
</body>
</html>
