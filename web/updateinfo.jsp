<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%
    String meter = (String) session.getAttribute("meter_no");
    String name = "", address = "", city = "", state = "", email = "", phone = "";

    if (meter != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Or your DB driver
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ebs", "root", "Server@321");
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM customer WHERE meter_no = '" + meter + "'");

            if (rs.next()) {
                name = rs.getString("name");
                address = rs.getString("address");
                city = rs.getString("city");
                state = rs.getString("state");
                email = rs.getString("email");
                phone = rs.getString("phone");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    } else {
        response.sendRedirect("login.jsp"); // If not logged in
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Customer Information</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f7f7;
            margin: 0;
            padding: 0;
        }

        h1 {
            text-align: center;
            margin-top: 20px;
            color: #2c3e50;
        }

        .form-container {
            width: 50%;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        label {
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 8px;
            display: block;
            color: #2c3e50;
        }

        input[type="text"], input[type="email"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 2px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
            background-color: #f5f5f5;
        }

        input[type="text"]:focus, input[type="email"]:focus {
            border-color: #3498db;
            outline: none;
            background-color: #fff;
        }

        input[type="submit"] {
            width: 100%;
            padding: 12px;
            font-size: 16px;
            font-weight: bold;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #2980b9;
        }

        .cancel-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            font-size: 16px;
        }

        .cancel-link a {
            color: #e74c3c;
            text-decoration: none;
            font-weight: bold;
        }

        .cancel-link a:hover {
            text-decoration: underline;
        }

        .form-header {
            text-align: center;
            margin-bottom: 20px;
            color: #2c3e50;
        }

        .form-container input {
            transition: all 0.3s ease;
        }

        .form-container {
            animation: fadeIn 0.5s ease-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>

    <div class="form-container">
        <h1>Update Customer Information</h1>
        
        <form action="updateinfo" method="post">
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" value="<%= name %>" readonly><br>

            <label for="meter_no">Meter Number:</label>
            <input type="text" id="meter_no" name="meter_no" value="<%= meter %>" readonly><br>

            <label for="address">Address:</label>
            <input type="text" id="address" name="address" value="<%= request.getAttribute("address") != null ? request.getAttribute("address") : "" %>" required><br>

            <label for="city">City:</label>
            <input type="text" id="city" name="city" value="<%= request.getAttribute("city") != null ? request.getAttribute("city") : "" %>" required><br>

            <label for="state">State:</label>
            <input type="text" id="state" name="state" value="<%= request.getAttribute("state") != null ? request.getAttribute("state") : "" %>" required><br>

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>" required><br>

            <label for="phone">Phone:</label>
            <input type="text" id="phone" name="phone" value="<%= request.getAttribute("phone") != null ? request.getAttribute("phone") : "" %>" required><br>

            <input type="submit" value="Update">
        </form>

        <div class="cancel-link">
            <a href="project.jsp">Cancel</a>
        </div>
    </div>

</body>
</html>
