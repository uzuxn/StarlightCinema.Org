<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Showtimes</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-900 text-white">
    <div class="container mx-auto py-12">
        <h1 class="text-4xl font-bold text-center mb-8">Movie Showtimes</h1>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            <%
                Connection conn = null;
                PreparedStatement ps = null;
                ResultSet rs = null;

                try {
                    // Load the database driver (Ensure your driver is added to the project)
                    Class.forName("com.mysql.cj.jdbc.Driver");

                    // Establish the connection
                    conn = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/starlightcinema", // Change this URL if needed
                        "root", // Your database username
                        "2797" // Your database password
                    );

                    // SQL query to join `showtimes` and `movies` tables
                    String sql = "SELECT s.showtimesId, s.showDate, s.showTime " +
                                 "FROM showtimes s " +
                                 "JOIN moviez m ON s.movieId = m.id";

                    ps = conn.prepareStatement(sql);
                    rs = ps.executeQuery();

                    // Loop through the results
                    while (rs.next()) {
                        int showtimeId = rs.getInt("showtimesId");
                        Date showDate = rs.getDate("showDate");
                        Time showTime = rs.getTime("showTime");
            %>
                        <!-- Showtime Card -->
                        <div class="bg-gray-800 rounded-lg shadow-lg p-6">
                            <p class="text-gray-400">Show Date: <%= showDate %></p>
                            <p class="text-gray-400">Show Time: <%= showTime %></p>
                            <a href="#" class="block bg-blue-600 text-center text-white py-2 mt-4 rounded-lg hover:bg-blue-700 transition">
                                Book Now
                            </a>
                        </div>
            <%
                    }
                } catch (Exception e) {
                    out.println("<p class='text-red-500'>Error: " + e.getMessage() + "</p>");
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (ps != null) ps.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        out.println("<p class='text-red-500'>Error closing resources: " + e.getMessage() + "</p>");
                    }
                }
            %>
        </div>
    </div>
</body>
</html>

