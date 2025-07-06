<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    String meter = (String) session.getAttribute("meter_no");
    if (meter == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String selectedMonth = request.getParameter("month");
    StringBuilder billText = new StringBuilder();

    if (selectedMonth != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ebs", "root", "Server@321");
            Statement stmt = con.createStatement();

            billText.append("\tReliance Power Limited\nELECTRICITY BILL GENERATED FOR THE MONTH\n\tOF ").append(selectedMonth).append(", 2022\n\n\n");

            ResultSet rs = stmt.executeQuery("SELECT * FROM customer WHERE meter_no = '" + meter + "'");
            if (rs.next()) {
                billText.append("\n    Customer Name: ").append(rs.getString("name"));
                billText.append("\n    Meter Number  : ").append(rs.getString("meter_no"));
                billText.append("\n    Address       : ").append(rs.getString("address"));
                billText.append("\n    City          : ").append(rs.getString("city"));
                billText.append("\n    State         : ").append(rs.getString("state"));
                billText.append("\n    Email         : ").append(rs.getString("email"));
                billText.append("\n    Phone         : ").append(rs.getString("phone"));
                billText.append("\n---------------------------------------------------\n");
            }

            rs = stmt.executeQuery("SELECT * FROM meter_info WHERE meter_no = '" + meter + "'");
            if (rs.next()) {
                billText.append("\n    Meter Location : ").append(rs.getString("meter_location"));
                billText.append("\n    Meter Type     : ").append(rs.getString("meter_type"));
                billText.append("\n    Phase Code     : ").append(rs.getString("phase_code"));
                billText.append("\n    Bill Type      : ").append(rs.getString("bill_type"));
                billText.append("\n    Days           : ").append(rs.getString("days"));
                billText.append("\n---------------------------------------------------\n");
            }

            rs = stmt.executeQuery("SELECT * FROM tax");
            if (rs.next()) {
                billText.append("\n    Cost Per Unit         : ").append(rs.getString("cost_per_unit"));
                billText.append("\n    Meter Rent            : ").append(rs.getString("meter_rent"));
                billText.append("\n    Service Charge        : ").append(rs.getString("service_charge"));
                billText.append("\n    Service Tax           : ").append(rs.getString("service_tax"));
                billText.append("\n    Swacch Bharat Cess    : ").append(rs.getString("swacch_bharat_cess"));
                billText.append("\n    Fixed Tax             : ").append(rs.getString("fixed_tax"));
                billText.append("\n");
            }

            rs = stmt.executeQuery("SELECT * FROM bill WHERE meter_no = '" + meter + "' AND month = '" + selectedMonth + "'");
            if (rs.next()) {
                billText.append("\n    Current Month : ").append(rs.getString("month"));
                billText.append("\n    Units Consumed: ").append(rs.getString("units"));
                billText.append("\n    Total Charges : ").append(rs.getString("totalbill"));
                billText.append("\n-------------------------------------------------------");
                billText.append("\n    Total Payable : ").append(rs.getString("totalbill")).append("\n");
            }

            rs.close();
            stmt.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Generate Bill</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f9f9f9;
            padding: 30px;
        }

        h1 {
            text-align: center;
            color: #2c3e50;
        }

        .container {
            max-width: 700px;
            margin: auto;
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 6px 12px rgba(0,0,0,0.1);
        }

        form {
            text-align: center;
            margin-bottom: 20px;
        }

        select, button {
            font-size: 16px;
            padding: 8px 16px;
            margin: 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        button {
            background-color: #3498db;
            color: white;
            cursor: pointer;
        }

        button:hover {
            background-color: #2980b9;
        }

        textarea {
            width: 100%;
            height: 500px;
            padding: 20px;
            font-size: 16px;
            font-family: monospace;
            border: 1px solid #ccc;
            border-radius: 8px;
            background-color: #fefefe;
            white-space: pre-wrap;
        }

        a {
            display: inline-block;
            margin-top: 20px;
            text-decoration: none;
            color: #3498db;
            font-weight: bold;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>Generate Electricity Bill</h1>

    <form method="post">
        <label for="month">Select Month:</label>
        <select name="month" id="month" required>
            <option value="" disabled selected>Select Month</option>
            <%
                String[] months = {"January", "February", "March", "April", "May", "June",
                                   "July", "August", "September", "October", "November", "December"};
                for (String m : months) {
                    String selected = m.equals(selectedMonth) ? "selected" : "";
            %>
            <option value="<%= m %>" <%= selected %>><%= m %></option>
            <% } %>
        </select>
        <button type="submit">Generate Bill</button>
    </form>

    <textarea readonly><%= billText.toString() %></textarea>

    <a href="project.jsp">← Back to Dashboard</a>
</div>

</body>
</html>
