<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.*, jakarta.servlet.http.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Panel</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* Styling */
        :root {
            --primary-bg: #0F0F23;
            --secondary-bg: #152033;
            --highlight: #2563EB;
            --text-light: #f5f6fa;
            --text-muted: #b2bec3;
            --card-bg: #2d2f41;
        }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: 'Arial', sans-serif; 
            color: var(--text-light); 
            background: var(--primary-bg); }
        .admin-container { 
            display: flex; 
            width: 100%; }
        .sidebar { 
            width: 250px; 
            background: var(--secondary-bg); 
            padding: 20px; }
        .sidebar nav ul li { 
            list-style: none; 
            margin: 15px 0; }
        .sidebar nav ul li a { 
            text-decoration: none; 
            color: var(--text-muted); 
            display: flex; 
            align-items: center; 
            gap: 10px; 
            padding: 10px; }
        .sidebar nav ul li a.active { 
            background: var(--highlight); 
            border-radius: 5px; 
            color: white; }
        .content { 
            flex: 1; 
            padding: 20px; }
        table { 
            width: 100%; 
            border-collapse: collapse; 
            margin-top: 20px; 
            background: var(--card-bg); }
        table th, table td { 
            padding: 15px; 
            text-align: center; 
            border-bottom: 1px solid var(--text-muted); 
            color: var(--text-light); }
        table th { 
            background-color: var(--highlight); }
        form input, form select { 
            margin: 10px 0; 
            padding: 10px; 
            width: 100%; 
            border-radius: 5px; }
        .btn { 
            padding: 10px 15px; 
            color: white; 
            background: var(--highlight); 
            border: none; 
            border-radius: 5px; 
            cursor: pointer; }
        /* Add styling for the admin name display */
        .admin-header {
            background: #152033;
            color: #f5f6fa;
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .admin-header .welcome {
            font-size: 18px;
        }
        .admin-header .logout {
            text-decoration: none;
            color: #f5f6fa;
            background: #2563EB;
            padding: 8px 15px;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <!-- Admin Header -->
<div class="admin-header">
    
    <a href="adminlogin.jsp" class="logout">Logout</a>
</div>


    <div class="admin-container">
        <!-- Sidebar -->
        <aside class="sidebar">
            <nav>
                <ul>                    
                    <li><a href="#dashboard" class="active"><i class="fas fa-home"></i> Dashboard</a></li>
                    <li><a href="#users"><i class="fas fa-users"></i> User Management</a></li>
                    <li><a href="#movies"><i class="fas fa-film"></i> Movie Management</a></li>
                    <li><a href="#showtimes"><i class="fas fa-clock"></i> Showtime Management</a></li>
                    <li><a href="#reservations"><i class="fas fa-ticket-alt"></i> Reservation Details</a></li>
                    <li><a href="#admins"><i class="fas fa-user-shield"></i> Admin Management</a></li>
                    <li><a href="#reports"><i class="fas fa-user-shield"></i> Analyze report</a></li>
                </ul>
            </nav>
                    <% String success = request.getParameter("success"); %>
<% String error = request.getParameter("error"); %>
<% if (success != null) { %>
    <p class="success"><%= success %></p>
<% } else if (error != null) { %>
    <p class="error"><%= error %></p>
<% } %>

        </aside>

        <!-- Main Content -->
        <main class="content">
            <!-- Admin Management -->

                        
        <section id="admins">
            <h2>Admin Management</h2>
    
            <!-- Add Admin Form -->
        <form method="POST" action="adminServ">
            <input type="hidden" name="action" value="add">
            <input type="text" name="name" placeholder="Admin Name" required>
            <input type="date" name="dob" placeholder="Date of Birth" required>
            <select name="gender" required>
                <option value="">Select Gender</option>
                <option value="Male">Male</option>
                <option value="Female">Female</option>
            </select>
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>
            <input type="text" name="role" placeholder="Role" required>
            <button class="btn" type="submit">Add Admin</button>
        </form>

    <!-- Admin List -->
    <table>
        <thead>
            <tr>
                <th>Name</th>
                <th>DOB</th>
                <th>Gender</th>
                <th>Role</th>
                <th>Email</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                // Fetching admin data from the database
                try {
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/starlightcinema", "root", "2797");
                    Statement stmt = con.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT * FROM admin");

                    while (rs.next()) {
                        String adminId = rs.getString("adminId"); // Assuming 'adminId' is the primary key
                        String name = rs.getString("name");
                        String dob = rs.getString("dob");
                        String gender = rs.getString("gender");
                        String role = rs.getString("role");
                        String email = rs.getString("email");

                        out.println("<tr>");
                        out.println("<td>" + name + "</td>");
                        out.println("<td>" + dob + "</td>");
                        out.println("<td>" + gender + "</td>");
                        out.println("<td>" + role + "</td>");
                        out.println("<td>" + email + "</td>");
                        out.println("<td>");
                        // Update Form
                        out.println("<form method='POST' action='adminServ' style='display:inline;'>");
                        out.println("<input type='hidden' name='action' value='update'>");
                        out.println("<input type='hidden' name='adminId' value='" + adminId + "'>");
                        out.println("<button type='submit' class='btn'>Update</button>");
                        out.println("</form>");
                        
                        // Delete Form
                        out.println("<form method='POST' action='adminServ' style='display:inline;'>");
                        out.println("<input type='hidden' name='action' value='delete'>");
                        out.println("<input type='hidden' name='adminId' value='" + adminId + "'>");
                        out.println("<button type='submit' class='btn' onclick='return confirm(\"Are you sure you want to delete this admin?\")'>Delete</button>");
                        out.println("</form>");
                        
                        out.println("</td>");
                        out.println("</tr>");
                    }
                } catch (Exception e) { 
                    out.println("<tr><td colspan='6'>Error: " + e.getMessage() + "</td></tr>"); 
                }
            %>
        </tbody>
    </table>
</section>

<!-- Popup Message Handling -->
<script>
    window.onload = function() {
        <% String successMessage = request.getParameter("success"); %>
        <% String errorMessage = request.getParameter("error"); %>

        if ('<%= successMessage %>' != "") {
            alert('<%= successMessage %>');
        }

        if ('<%= errorMessage %>' != "") {
            alert('<%= errorMessage %>');
        }
    }
</script>

                    <!-- add movies -->
            <section id="movies">
    <h2>Movie Management</h2>
    <!-- Add Movie Form -->
    <form method="POST" action="AdminMovieServ">
    <input type="hidden" name="action" value="add">
    <input type="text" name="name" placeholder="Movie Title" required>
    <input type="text" name="rating" placeholder="Rating" required>
    <input type="text" name="poster_url" placeholder="Poster" required>
    <input type="text" name="description" placeholder="Description" required>
    <button class="btn" type="submit">Add Movie</button>
</form>

    <!-- Movie List -->
    <table>
        <thead>
            <tr><th>Movie Title</th><th>Rating</th><th>Poster URL</th><th>Description</th><th>Actions</th></tr>
        </thead>
        <tbody>
            <%
                try {
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/starlightcinema", "root", "2797");
                    Statement stmt = con.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT * FROM moviez");
                    while (rs.next()) {
                        String movieId = rs.getString("Id"); // Assuming 'movieId' is the primary key
                        String name = rs.getString("name");
                        String rating = rs.getString("rating");
                        String posterUrl = rs.getString("poster_url");
                        String description = rs.getString("description");

                        out.println("<tr>");
                        out.println("<td>" + name + "</td>");
                        out.println("<td>" + rating + "</td>");
                        out.println("<td>" + posterUrl + "</td>");
                        out.println("<td>" + description + "</td>");
                        out.println("<td>");
                        
                        // Delete Form
                        out.println("<form method='POST' action='AdminMovieServ' style='display:inline;'>");
                        out.println("<input type='hidden' name='action' value='delete'>");
                        out.println("<input type='hidden' name='movieId' value='" + movieId + "'>");
                        out.println("<button type='submit' class='btn' onclick='return confirm(\"Are you sure you want to delete this movie?\")'>Delete</button>");
                        out.println("</form>");
                        
                        out.println("</td>");
                        out.println("</tr>");
                    }
                } catch (Exception e) { 
                    out.println("<tr><td colspan='5'>Error: " + e.getMessage() + "</td></tr>"); 
                }
            %>
        </tbody>
    </table>
</section>

            <!-- Showtime Management -->
            <section id="showtimes">
                <h2>Showtime Management</h2>
                
                <!-- Add Showtime Form -->
<form method="POST" action="showtimeServ">
    <input type="hidden" name="action" value="add">
    <input type="text" name="movieId" placeholder="Movie ID" required>
    
    <!-- Custom Date Input (YYYY/MM/DD format) -->
    <input type="text" name="showDate" placeholder="Show Date (YYYY/MM/DD)" required>

    <!-- Custom Time Input (HH:MM:SS format) -->
    <input type="text" name="showTime" placeholder="Show Time (HH:MM:SS)" required>

    <button class="btn" type="submit">Add Showtime</button>
</form>

<!-- Update Showtime Form -->
<form method="POST" action="showtimeServ">
    <input type="hidden" name="action" value="update">
    <input type="text" name="showtimesId" placeholder="Showtime ID" required>
    <input type="text" name="movieId" placeholder="Movie ID" required>
    
    <!-- Custom Date Input (YYYY/MM/DD format) -->
    <input type="text" name="showDate" placeholder="Show Date (YYYY/MM/DD)" required>

    <!-- Custom Time Input (HH:MM:SS format) -->
    <input type="text" name="showTime" placeholder="Show Time (HH:MM:SS)" required>

    <button class="btn" type="submit">Update Showtime</button>
</form>

                
<!-- Delete Showtime Form -->
<form method="POST" action="showtimeServ">
    <input type="hidden" name="action" value="delete">
    <input type="text" name="showtimesId" placeholder="Showtime ID" required>
    <button class="btn" type="submit">Delete Showtime</button>
</form>


                <!-- Showtime Table -->
                <table>
                    <thead>
                        <tr>
                            <th>Showtime ID</th>
                            <th>Movie ID</th>
                            <th>Show Date</th>
                            <th>Show Time</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try {
                                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/starlightcinema", "root", "2797");
                                Statement stmt = con.createStatement();
                                ResultSet rs = stmt.executeQuery("SELECT * FROM showtimes");
                                while (rs.next()) {
                                    out.println("<tr><td>" + rs.getInt("showtimesId") + "</td><td>" + rs.getInt("movieId") + "</td><td>" + rs.getDate("showDate") + "</td><td>" + rs.getTime("showTime") + "</td></tr>");
                                }
                            } catch (Exception e) {
                                out.println("<tr><td colspan='4'>Error: " + e.getMessage() + "</td></tr>");
                            }
                        %>
                    </tbody>
                </table>
            </section>
                    <script>
            document.querySelectorAll('form').forEach(form => {
    form.addEventListener('submit', function (event) {
        const dateInput = form.querySelector('[name="showDate"]');
        const timeInput = form.querySelector('[name="showTime"]');

        let isValid = true;

        // Validate date in YYYY/MM/DD format
        const dateRegex = /^\d{4}\/\d{2}\/\d{2}$/;
        if (!dateRegex.test(dateInput.value)) {
            alert("Invalid date format. Please use YYYY/MM/DD.");
            isValid = false;
        }

        // Validate time in HH:MM:SS format
        const timeRegex = /^\d{2}:\d{2}:\d{2}$/;
        if (!timeRegex.test(timeInput.value)) {
            alert("Invalid time format. Please use HH:MM:SS.");
            isValid = false;
        }

        if (!isValid) {
            event.preventDefault(); // Prevent form submission if validation fails
        }
    });
});
</script>
             
                    <!-- users -->
             <section id="users">
    <h2>User Management</h2>

    <!-- Add User Form -->
    <form method="POST" action="userServ">
        <input type="hidden" name="action" value="add">
        <input type="text" name="name" placeholder="User Name" required>
        <input type="email" name="email" placeholder="Email" required>
        <input type="password" name="password" placeholder="Password" required>
        <input type="text" name="contactNum" placeholder="Contact Number" required>
        <input type="date" name="dob" placeholder="Date of Birth" required>
        <select name="gender" required>
            <option value="">Select Gender</option>
            <option value="Male">Male</option>
            <option value="Female">Female</option>
        </select>
        <button class="btn" type="submit">Add User</button>
    </form>

    <!-- User List Table -->
    <table>
        <thead>
            <tr>
                <th>Name</th>
                <th>Email</th>
                <th>Contact Number</th>
                <th>Date of Birth</th>
                <th>Gender</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                try {
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/starlightcinema", "root", "2797");
                    Statement stmt = con.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT * FROM users");
                    while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getString("name") %></td>
                <td><%= rs.getString("email") %></td>
                <td><%= rs.getString("contactNum") %></td>
                <td><%= rs.getString("dob") %></td>
                <td><%= rs.getString("gender") %></td>
                <td>
                    <!-- Update User Form -->
                    <form method="POST" action="userServ" style="display:inline;">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="userId" value="<%= rs.getString("userId") %>">
                        <button type="submit" class="btn">Update</button>
                    </form>
                    
                    <!-- Delete User Form -->
                    <form method="POST" action="userServ" style="display:inline;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="userId" value="<%= rs.getString("userId") %>">
                        <button type="submit" class="btn" onclick="return confirm('Are you sure you want to delete this user?')">Delete</button>
                    </form>
                </td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    out.println("Error: " + e.getMessage());
                }
            %>
        </tbody>
    </table>
</section>

                    <!-- Reservations -->
            <section id="reservations">
                <h2>Reservations Details</h2>
                
                <table>
                    <thead>
                        <tr><th>MovieId</th><th>User Name</th><th>SeatCount</th><th>Total Amount</th></tr>
                    </thead>
                    <tbody>
                        <%
                            try {
                                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/starlightcinema", "root", "2797");
                                Statement stmt = con.createStatement();
                                ResultSet rs = stmt.executeQuery("SELECT * FROM reservations");
                                while (rs.next()) {
                                    out.println("<tr><td>" + rs.getString("movieid") + "</td><td>" + rs.getString("userName") + "</td><td>"+ rs.getString("seatCount")+ "</td><td>"+ rs.getString("totalAmt")  + "</td></tr>");
                                }
                            } catch (Exception e) { out.println("Error: " + e.getMessage()); }
                        %>
                    </tbody>
                </table>
            </section> 
                    
            <section id="reports">
    <h2>Analyze Report</h2>
    <form method="GET" action="reportServ">
        <button class="btn" type="submit">Generate Analyze Report (PDF)</button>
    </form>
</section>


        </main>
    </div>
</body>
</html>
