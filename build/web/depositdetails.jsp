<%@ page import="java.sql.*,java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Deposit Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
        }
        h2 {
            margin-bottom: 20px;
        }
        select, button {
            padding: 8px;
            margin-right: 10px;
            font-size: 16px;
        }
        .table-container {
            margin-top: 30px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 12px;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
        }
        .print-btn {
            background-color: #4CAF50;
            color: white;
            padding: 10px 18px;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
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

<h2>Deposit Details</h2>

<form method="get">
    <label>Search By Meter Number:</label>
    <select name="meter">
        <option value="">-- Select Meter --</option>
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ebs", "root", "Server@321");
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT meter_no FROM customer");

                while (rs.next()) {
                    String meter = rs.getString("meter_no");
                    String selected = request.getParameter("meter") != null && request.getParameter("meter").equals(meter) ? "selected" : "";
        %>
                    <option value="<%= meter %>" <%= selected %>><%= meter %></option>
        <%
                }
                rs.close(); stmt.close(); conn.close();
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            }
        %>
    </select>

    <label>Search By Month:</label>
    <select name="month">
        <%
            String[] months = { "January", "February", "March", "April", "May", "June",
                                "July", "August", "September", "October", "November", "December" };
            String selectedMonth = request.getParameter("month");
            for (String m : months) {
                String selected = m.equals(selectedMonth) ? "selected" : "";
        %>
                <option value="<%= m %>" <%= selected %>><%= m %></option>
        <%
            }
        %>
    </select>

    <button type="submit">Search</button>
    <button type="button" onclick="printTable()" class="print-btn">Print</button>
</form>

<div class="table-container">
<%
    String meter = request.getParameter("meter");
    String month = request.getParameter("month");
    if (meter != null && month != null && !meter.equals("") && !month.equals("")) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ebs", "root", "Server@321");
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM bill WHERE meter_no=? AND month=?");
            ps.setString(1, meter);
            ps.setString(2, month);
            ResultSet rs = ps.executeQuery();

            boolean hasData = false;
%>
            <table>
                <tr>
                    <th>Meter No</th>
                    <th>Month</th>
                    <th>Units</th>
                    <th>Total Bill</th>
                    <th>Status</th>
                </tr>
<%
            while (rs.next()) {
                hasData = true;
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

            if (!hasData) {
%>
                <tr><td colspan="5">No records found.</td></tr>
<%
            }

            rs.close(); ps.close(); conn.close();
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
    }
%>
</table>
</div>

</body>
</html>
