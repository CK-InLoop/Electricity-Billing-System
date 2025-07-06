<%@ page import="java.sql.*,java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 30px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table, th, td {
            border: 1px solid #ccc;
        }
        th, td {
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        .print-btn {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            margin-top: 20px;
        }
        .print-btn:hover {
            background-color: #45a049;
        }
    </style>
    <script>
        function printTable() {
            window.print();
        }
    </script>
</head>
<body>

<h2>Customer Details</h2>

<table>
    <tr>
        <th>Name</th>
        <th>Meter No</th>
        <th>Address</th>
        <th>City</th>
        <th>State</th>
        <th>Email</th>
        <th>Phone</th>
    </tr>

    <%
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ebs", "root", "Server@321");
            stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT * FROM customer");

            while (rs.next()) {
    %>
        <tr>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("meter_no") %></td>
            <td><%= rs.getString("address") %></td>
            <td><%= rs.getString("city") %></td>
            <td><%= rs.getString("state") %></td>
            <td><%= rs.getString("email") %></td>
            <td><%= rs.getString("phone") %></td>
        </tr>
    <%
            }
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (stmt != null) stmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    %>
</table>

<button class="print-btn" onclick="printTable()">Print</button>

</body>
</html>
