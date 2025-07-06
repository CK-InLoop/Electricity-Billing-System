<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String meter = (String) session.getAttribute("meter_no");
    if (meter == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Bill Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }

        h1 {
            text-align: center;
            color: #2c3e50;
        }

        .table-container {
            max-width: 900px;
            margin: 0 auto;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        th, td {
            padding: 12px;
            border-bottom: 1px solid #ccc;
            text-align: center;
        }

        th {
            background-color: #3498db;
            color: white;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        a.back {
            display: inline-block;
            margin-top: 20px;
            text-decoration: none;
            color: #3498db;
            font-weight: bold;
        }

        a.back:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<h1>Bill Details</h1>

<div class="table-container">
    <table>
        <tr>
            <th>Meter No</th>
            <th>Month</th>
            <th>Units</th>
            <th>Total Bill</th>
            <th>Status</th>
        </tr>

        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ebs", "root", "Server@321");
                Statement stmt = con.createStatement();
                String query = "SELECT * FROM bill WHERE meter_no = '" + meter + "'";
                ResultSet rs = stmt.executeQuery(query);

                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getString("meter_no") %></td>
            <td><%= rs.getString("month") %></td>
            <td><%= rs.getString("units") %></td>
            <td><%= rs.getString("totalbill") %></td>
            <td><%= rs.getString("status") %></td>
        </tr>
        <%
                }
                rs.close();
                stmt.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </table>

    <a href="project.jsp" class="back">← Back to Dashboard</a>
</div>

</body>
</html>
