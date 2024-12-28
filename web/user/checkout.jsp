<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="Starlight.admin.model.moviez" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - Starlight Cinema</title>
    <script src="https://www.paypal.com/sdk/js?client-id=Ae3nLNcC-V_7uv5pswhVgrbmxZ2V0njP8O4sjIX-XfyOH6hlAlUWL0X1TLV9L3yq_RiJvMuYgknZ7ef1&currency=USD"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #111827;
            color: #e5e7eb;
            margin: 0;
            padding: 0;
        }

        h1 {
            text-align: center;
            font-size: 2.5rem;
            margin-top: 20px;
            color: #f9fafb;
        }

        .container {
            width: 80%;
            margin: 30px auto;
            background-color: #1f2937;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.5);
            overflow: hidden;
            padding: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            color: #d1d5db;
        }

        th,
        td {
            padding: 15px;
            text-align: center;
            border-bottom: 1px solid #374151;
        }

        th {
            background-color: #374151;
            color: #f9fafb;
        }

        tr:nth-child(even) {
            background-color: #111827;
        }

        .btn-container {
            text-align: center;
            margin: 20px 0;
        }

        .btn {
            display: inline-block;
            padding: 12px 20px;
            margin: 10px;
            font-size: 1rem;
            font-weight: bold;
            text-decoration: none;
            color: #fff;
            border-radius: 6px;
            transition: all 0.3s ease;
        }

        .btn-pay {
            background-color: #10b981;
        }

        .btn-pay:hover {
            background-color: #059669;
        }

        .btn-cancel {
            background-color: #ef4444;
        }

        .btn-cancel:hover {
            background-color: #dc2626;
        }

        .info {
            text-align: center;
            font-size: 1.1rem;
            margin-top: 20px;
            color: #9ca3af;
        }

        .info a {
            color: #3b82f6;
            text-decoration: none;
        }

        .info a:hover {
            text-decoration: underline;
        }
        
    </style>
</head>

<body>
    <div class="container">
        <h1>Checkout</h1>

        <!-- Reservation Receipt -->
        <table>
            <tr>
                <th>Movie Name</th>
                <th>User Name</th>
                <th>Seats Reserved</th>
                <th>Total Price</th>
            </tr>
            <tr>
                <td><%= request.getAttribute("movieName") != null ? request.getAttribute("movieName") : "N/A" %></td>
                <td><%= request.getAttribute("userName") != null ? request.getAttribute("userName") : "N/A" %></td>
                <td><%= request.getAttribute("seatCount") != null ? request.getAttribute("seatCount") : "0" %></td>
                <td>$<%= request.getAttribute("totalPrice") != null ? request.getAttribute("totalPrice") : "0.00" %></td>
               

            </tr>
        </table>

        
           <!-- Buttons -->
        <div class="btn-container">
            <!-- PayPal Button Container -->
            <div id="paypal-button-container"></div>
            <a href="cancelReservationServlet?reservationId=<%= request.getAttribute("reservationId") %>" class="btn btn-cancel">
                <i class="fas fa-times-circle"></i> Cancel
            </a>
        </div>

<script>
    // Render the PayPal Button
    paypal.Buttons({
        // Create an order
        createOrder: function(data, actions) {
            return actions.order.create({
                purchase_units: [{
                    amount: {
                        value: '<%= request.getAttribute("totalPrice") != null ? request.getAttribute("totalPrice") : "0.00" %>'
                    },
                    description: '<%= request.getAttribute("movieName") != null ? request.getAttribute("movieName") : "Movie Reservation" %>'
                }]
            });
        },
        // On approval
        onApprove: function(data, actions) {
            return actions.order.capture().then(function(details) {
                // Display success message
                alert('Transaction completed by ' + details.payer.name.given_name);

                // Redirect to success page or perform further actions
                window.location.href = "paymentSuccessServlet?transactionId=" + details.id;
            });
        },
        // On cancel
        onCancel: function(data) {
            alert('Payment cancelled.');
        },
        // On error
        onError: function(err) {
            console.error(err);
            alert('An error occurred during the transaction.');
        }
    }).render('#paypal-button-container');
</script>


        <!-- Additional Information -->
        <div class="info">
            If you need help with your reservation, <a href="contactus.jsp">contact us</a> 
        </div>
    </div>
</body>

</html>
