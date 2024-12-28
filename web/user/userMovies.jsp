<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Available Movies</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-900 text-white">

    <!-- Header -->
    <header class="bg-gray-800 shadow-lg py-6 mb-8">
        <%-- Logout Button --%>
        <a href="logoutServ" class="absolute top-6 right-6 bg-gray-600 hover:bg-gray-700 text-white py-2 px-4 rounded-full shadow-lg transition duration-300">
            Log Out
        </a>
        <div class="container mx-auto text-center">
            <h1 class="text-4xl font-bold">Available Movies</h1>
        </div>
    </header>


    <!-- Movies Section -->
    <section class="container mx-auto px-4">
        <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-8">
            <%
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;
                try {
                    // Database connection
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/starlightcinema", "root", "2797");

                    // Query to fetch movies, showtimes, and ratings
                    String sql = "SELECT m.id, m.name, m.description, m.poster_url, m.rating, s.showtimesId, s.showDate, s.showTime " +
                                 "FROM moviez m " +
                                 "JOIN showtimes s ON m.id = s.movieId";
                    pstmt = conn.prepareStatement(sql);
                    rs = pstmt.executeQuery();

                    // Check if no results
                    if (!rs.isBeforeFirst()) {
            %>
                        <p class="text-center text-xl font-semibold col-span-full">No movies are currently available.</p>
            <%
                    }

                    // Loop through the results and create movie cards with showtimes and rating
                    while (rs.next()) {
                        String id = rs.getString("id");
                        String name = rs.getString("name");
                        String description = rs.getString("description");
                        String poster_url = rs.getString("poster_url");
                        double rating = rs.getDouble("rating");
                        Date showDate = rs.getDate("showDate");
                        Time showTime = rs.getTime("showTime");
            %>
            <!-- Movie Card -->
            <div class="bg-gray-800 rounded-lg shadow-lg overflow-hidden transform hover:scale-105 transition duration-300">
                <!-- Movie Poster -->
                <img src="<%= poster_url %>" alt="<%= name %>" class="w-full h-64 object-cover">
                
                <!-- Movie Details -->
                <div class="p-4">
                    <h2 class="text-2xl font-bold mb-2"><%= name %></h2>
                    <p class="text-sm text-gray-400 mb-4"><%= description %></p>

                    <!-- Movie Rating -->
                    <div class="mb-4">
                        <p class="text-yellow-400 font-semibold">Rating: <%= rating %>/10</p>
                    </div>

                    <!-- Showtimes for the movie -->
                    <div class="text-gray-300">
                        <p><strong>Showtimes:</strong></p>
                        <ul>
                            <li class="mb-2">
                                <span class="font-semibold">Date:</span> <%= showDate %><br>
                                <span class="font-semibold">Time:</span> <%= showTime %>
                            </li>
                        </ul>
                    </div>
                  <%-- Reserve Button --%>
                    <div class="text-center">
                        <%
                            // Check if user is logged in
                            String loggedInUser = (String) session.getAttribute("user");
                            if (loggedInUser != null) {
                        %>
                            <a href="reservation.jsp?movieId=<%= rs.getInt("id") %>" 
                               class="bg-blue-600 hover:bg-blue-700 text-white font-semibold py-2 px-4 rounded-full transition duration-300">
                                Reserve Seats
                            </a>
                        <%
                            } else {
                        %>
                            <a href="Userlogin.jsp?message= Please log in to reserve seats" 
                               class="bg-red-600 hover:bg-red-700 text-white font-semibold py-2 px-4 rounded-full transition duration-300">
                                Log in to Reserve
                            </a>
                        <%
                            }
                        %>
                    </div>
                </div>
            </div>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
            %>
                <!-- Error Message -->
                <p class="text-center text-red-500 col-span-full">Error fetching movies: <%= e.getMessage() %></p>
            <%
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (pstmt != null) pstmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
        </div>
    </section>

    <!-- Footer -->
    <footer class="mt-16 bg-gray-800 py-4 text-center text-gray-400">
        <p>&copy; 2024 Starlight Cinema. All rights reserved.</p>
    </footer>
</body>
</html>
