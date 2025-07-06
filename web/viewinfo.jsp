<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page session="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<html>
<head>
    <title>View Customer Information</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: white;
            padding: 30px;
        }
        h2 {
            text-align: center;
        }
        .container {
            width: 800px;
            margin: auto;
            border: 1px solid #ccc;
            padding: 20px;
            background-color: #f9f9f9;
        }
        .info {
            display: grid;
            grid-template-columns: 200px 1fr;
            row-gap: 15px;
            margin-bottom: 20px;
        }
        label {
            font-weight: bold;
        }
        .button {
            text-align: center;
        }
        button {
            background-color: black;
            color: white;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
        }
        img {
            display: block;
            margin: 20px auto;
            max-width: 100%;
            height: auto;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>View Customer Information</h2>
    <div class="info">
        <label>Name:</label> <div><%= name %></div>
        <label>Meter Number:</label> <div><%= meter %></div>
        <label>Address:</label> <div><%= address %></div>
        <label>City:</label> <div><%= city %></div>
        <label>State:</label> <div><%= state %></div>
        <label>Email:</label> <div><%= email %></div>
        <label>Phone:</label> <div><%= phone %></div>
    </div>
    <div class="button">
        <form action="project.jsp" method="get">
            <button type="submit">Cancel</button>
        </form>
    </div>
</div>
</body>
</html>
