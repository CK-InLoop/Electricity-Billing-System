<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String usertype = (String) session.getAttribute("usertype");
    String meter = (String) session.getAttribute("meter");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Electricity Billing Dashboard</title>
    <style>
        body {
            margin: 0;
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            background-image: url('icon/elect1.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
        }
        .navbar {
            display: flex;
            background-color: #000000a6;
            padding: 10px;
        }
        .menu {
            margin-right: 20px;
            position: relative;
        }
        .menu a {
            color: white;
            padding: 8px 12px;
            text-decoration: none;
            display: block;
        }
        .menu:hover .dropdown {
            display: block;
        }
        .dropdown {
            display: none;
            position: absolute;
            background-color: white;
            min-width: 160px;
            z-index: 1;
            top: 35px;
        }
        .dropdown a {
            color: black;
            padding: 8px 12px;
            text-decoration: none;
        }
        .dropdown a:hover {
            background-color: #ddd;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <% if ("Admin".equals(usertype)) { %>
            <div class="menu">
                <a href="#">Master</a>
                <div class="dropdown">
                    <a href="newcustomer.jsp">New Customer</a>
                    <a href="customerdetails.jsp">Customer Details</a>
                    <a href="depositdetails.jsp">Deposit Details</a>
                    <a href="calculatebill.jsp">Calculate Bill</a>
                </div>
            </div>
        <% } else { %>
            <div class="menu">
                <a href="#">Information</a>
                <div class="dropdown">
                    <a href="updateinfo.jsp?meter=<%=meter%>">Update Information</a>
                    <a href="viewinfo.jsp?meter=<%=meter%>">View Information</a>
                </div>
            </div>
            <div class="menu">
                <a href="#">User</a>
                <div class="dropdown">
                    <a href="paybill.jsp?meter=<%=meter%>">Pay Bill</a>
                    <a href="billdetails.jsp?meter=<%=meter%>">Bill Details</a>
                </div>
            </div>
            <div class="menu">
                <a href="#">Report</a>
                <div class="dropdown">
                    <a href="generatebill.jsp?meter=<%=meter%>">Generate Bill</a>
                </div>
            </div>
        <% } %>
        <div class="menu">
            <a href="#">Utility</a>
            <div class="dropdown">
                <a href="calculator.jsp">Calculator</a>
            </div>
        </div>
        <div class="menu">
            <a href="login.jsp">Exit</a>
        </div>
    </div>
</body>
</html>
