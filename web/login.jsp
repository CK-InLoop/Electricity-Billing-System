<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #2980b9, #6dd5fa);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .login-container {
            background-color: white;
            padding: 40px 35px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 400px;
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #2c3e50;
        }

        label {
            font-weight: 600;
            display: block;
            margin-bottom: 5px;
            color: #34495e;
        }

        input[type="text"],
        input[type="password"],
        select {
            width: 100%;
            padding: 10px 14px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 15px;
            outline: none;
            box-sizing: border-box;
        }

        input[type="submit"],
        input[type="reset"] {
            width: 48%;
            padding: 10px;
            font-size: 16px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            margin-right: 4%;
        }

        input[type="submit"] {
            background-color: #3498db;
            color: white;
        }

        input[type="submit"]:hover {
            background-color: #2980b9;
        }

        input[type="reset"] {
            background-color: #ecf0f1;
        }

        input[type="reset"]:hover {
            background-color: #dcdde1;
        }

        .footer-link {
            display: block;
            margin-top: 15px;
            text-align: center;
        }

        .footer-link a {
            color: #3498db;
            text-decoration: none;
            font-weight: bold;
        }

        .footer-link a:hover {
            text-decoration: underline;
        }

        .error-message {
            text-align: center;
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>

<div class="login-container">
    <h2>Login</h2>
    <form action="login" method="post">
        <label>Username:</label>
        <input type="text" name="username" required>

        <label>Password:</label>
        <input type="password" name="password" required>

        <label>Login as:</label>
        <select name="usertype" required>
            <option value="Admin">Admin</option>
            <option value="Customer">Customer</option>
        </select>

        <div style="display: flex; justify-content: space-between;">
            <input type="submit" value="Login">
            <input type="reset" value="Cancel">
        </div>

        <div class="footer-link">
            Don't have an account? <a href="signup.jsp">Signup</a>
        </div>
    </form>

    <% 
        if (request.getAttribute("error") != null) {
    %>
        <div class="error-message">
            <%= request.getAttribute("error") %>
        </div>
    <% 
        } 
    %>
</div>

</body>
</html>
