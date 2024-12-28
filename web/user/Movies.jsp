<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Available Movies</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .header {
            text-align: center;
            margin-bottom: 20px;
        }
        .header h1 {
            margin: 0;
            color: #333;
        }
        .movie-list {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }
        .movie-card {
            background: #fafafa;
            border: 1px solid #ddd;
            border-radius: 8px;
            overflow: hidden;
            width: 300px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s;
        }
        .movie-card:hover {
            transform: scale(1.05);
        }
        .movie-card img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }
        .movie-card .details {
            padding: 15px;
        }
        .movie-card .details h2 {
            margin: 0 0 10px;
            font-size: 1.2em;
            color: #333;
        }
        .movie-card .details p {
            font-size: 0.9em;
            color: #666;
            margin-bottom: 10px;
        }
        .movie-card .details button {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 10px 15px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1em;
        }
        .movie-card .details button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Available Movies</h1>
        </div>
        <div class="movie-list">
            <%
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    // Database connection
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/starlightcinema", "root", "2797");

                    // Query to fetch movies
                    String sql = "SELECT movieid, title, description, duration, poster FROM moviez";
                    pstmt = conn.prepareStatement(sql);
                    rs = pstmt.executeQuery();

                    while (rs.next()) {
                        String movieId = rs.getString("movieid");
                        String title = rs.getString("title");
                        String description = rs.getString("description");
                        String duration = rs.getString("duration");
                        String poster = rs.getString("poster"); // URL or file path to the movie poster
            %>
            <div class="movie-card">
                <img src="<%= poster %>" alt="<%= title %>">
                <div class="details">
                    <h2><%= title %></h2>
                    <p><%= description %></p>
                    <p><strong>Duration:</strong> <%= duration %> minutes</p>
                    <form action="reserveMovie" method="post">
                        <input type="hidden" name="movieid" value="<%= movieId %>">
                        <button type="submit">Reserve</button>
                    </form>
                </div>
            </div>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
            %>
                <p>Error fetching movies: <%= e.getMessage() %></p>
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
    </div>
</body>
</html>
