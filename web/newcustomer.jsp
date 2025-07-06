
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.Random" %>
<%
    Random ran = new Random();
    long number = Math.abs(ran.nextLong() % 1000000);
    String meterNumber = String.valueOf(number);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>New Customer</title>
    <style>
        body {
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f8ff;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 700px;
            margin: 50px auto;
            display: flex;
            background: white;
            box-shadow: 0 0 15px rgba(0,0,0,0.2);
        }
        .form-section {
            padding: 30px;
            width: 60%;
        }
        .form-section h2 {
            text-align: center;
            margin-bottom: 30px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            font-weight: bold;
        }
        input[type="text"], input[type="email"], input[type="tel"] {
            width: 90%;
            padding: 8px;
            margin-top: 5px;
        }
        .btns {
            margin-top: 20px;
        }
        button {
            padding: 8px 20px;
            background: black;
            color: white;
            border: none;
            margin-right: 10px;
            cursor: pointer;
        }
        .img-section {
            width: 40%;
            background: url('icon/hicon1.jpg') no-repeat center center;
            background-size: cover;
        }
    </style>
</head>
<body>
    <form action="newcustomer" method="post">
        <div class="container">
            <div class="form-section">
                <h2>New Customer</h2>

                <div class="form-group">
                    <label for="name">Customer Name</label>
                    <input type="text" name="name" id="name" required>
                </div>

                <div class="form-group">
                    <label>Meter Number</label>
                    <input type="text" name="meter" value="<%=meterNumber%>" readonly>
                </div>

                <div class="form-group">
                    <label for="address">Address</label>
                    <input type="text" name="address" id="address" required>
                </div>

                <div class="form-group">
                    <label for="city">City</label>
                    <input type="text" name="city" id="city" required>
                </div>

                <div class="form-group">
                    <label for="state">State</label>
                    <input type="text" name="state" id="state" required>
                </div>

                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" name="email" id="email" required>
                </div>

                <div class="form-group">
                    <label for="phone">Phone Number</label>
                    <input type="tel" name="phone" id="phone" required>
                </div>

                <div class="btns">
                    <button type="submit">Next</button>
                    <button type="button" onclick="window.location.href='project.jsp'">Cancel</button>
                </div>
            </div>

            <div class="img-section"></div>
        </div>
    </form>
</body>
</html>
