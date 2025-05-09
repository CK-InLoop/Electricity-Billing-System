<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Signup</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #8e44ad, #3498db);
            margin: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .signup-container {
            background-color: #fff;
            padding: 35px 30px;
            border-radius: 12px;
            width: 100%;
            max-width: 450px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #2c3e50;
        }

        label {
            display: block;
            font-weight: 600;
            margin-bottom: 5px;
            color: #34495e;
        }

        input[type="text"],
        input[type="password"],
        select {
            width: 100%;
            padding: 10px;
            margin-bottom: 18px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 14px;
            box-sizing: border-box;
        }

        input[type="submit"] {
            background-color: #8e44ad;
            color: #fff;
            padding: 12px;
            font-size: 16px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            width: 100%;
            margin-top: 10px;
        }

        input[type="submit"]:hover {
            background-color: #732d91;
        }

        #meter {
            display: none;
        }
    </style>
</head>
<body>

<div class="signup-container">
    <h2>Signup Page</h2>
    <%
        String message = null;
        if (request.getMethod().equalsIgnoreCase("POST")) {
            String accountType = request.getParameter("accountType");
            String meter = request.getParameter("meter");
            String username = request.getParameter("username");
            String name = request.getParameter("name");
            String password = request.getParameter("password");
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ebs", "root", "Server@321");
                String query;
                if ("Admin".equals(accountType)) {
                    query = "INSERT INTO login (meter_no, username, name, password, user) VALUES (?, ?, ?, ?, ?)";
                    PreparedStatement ps = conn.prepareStatement(query);
                    ps.setString(1, meter);
                    ps.setString(2, username);
                    ps.setString(3, name);
                    ps.setString(4, password);
                    ps.setString(5, accountType);
                    ps.executeUpdate();
                    message = "Admin account created successfully!";
                } else if ("Customer".equals(accountType)) {
                    query = "UPDATE login SET username=?, password=?, user=? WHERE meter_no=?";
                    PreparedStatement ps = conn.prepareStatement(query);
                    ps.setString(1, username);
                    ps.setString(2, password);
                    ps.setString(3, accountType);
                    ps.setString(4, meter);
                    int updated = ps.executeUpdate();
                    if (updated > 0) {
                        message = "Customer account created successfully!";
                    } else {
                        message = "Meter number not found. Please contact admin.";
                    }
                }
                conn.close();
            } catch (Exception e) {
                message = "Signup failed: " + e.getMessage();
            }
        }
    %>
    <form action="signup.jsp" method="post">
        <label for="accountType">Account Type:</label>
        <select name="accountType" onchange="toggleMeter(this.value)">
            <option value="Admin">Admin</option>
            <option value="Customer">Customer</option>
        </select>

        <label for="meter" id="meterLabel" style="display:none;">Meter No:</label>
        <input type="text" name="meter" id="meter">

        <label for="username">Username:</label>
        <input type="text" name="username" required>

        <label for="name">Name:</label>
        <input type="text" name="name" required>

        <label for="password">Password:</label>
        <input type="password" name="password" required>

        <input type="submit" value="Create Account">
    </form>
    <% if (message != null) { %>
        <div style="color: green; text-align: center; margin-bottom: 15px;">
            <%= message %>
        </div>
    <% } %>
    <div style="text-align:center; margin-top: 20px;">
        Already have an account? <a href="login.jsp">Login here</a>
    </div>
</div>

<script>
    function toggleMeter(type) {
        const meterInput = document.getElementById('meter');
        const meterLabel = document.getElementById('meterLabel');
        if (type === 'Customer') {
            meterInput.style.display = 'block';
            meterLabel.style.display = 'block';
        } else {
            meterInput.style.display = 'none';
            meterLabel.style.display = 'none';
        }
    }
</script>

</body>
</html>
