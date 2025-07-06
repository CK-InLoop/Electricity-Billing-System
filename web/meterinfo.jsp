
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Random" %>
<!DOCTYPE html>
<html>
<head>
    <title>Meter Info</title>
</head>
<body style="background-color:#ADD8E6; font-family:Tahoma;">
    <h2>Meter Information</h2>
    <form action="meterinfo" method="post">
        <label>Meter Number:</label>
        <input type="text" name="meter" value="<%= request.getParameter("meter") %>" readonly><br><br>

        <label>Meter Location:</label>
        <select name="location">
            <option>Outside</option>
            <option>Inside</option>
        </select><br><br>

        <label>Meter Type:</label>
        <select name="type">
            <option>Electric Meter</option>
            <option>Solar Meter</option>
            <option>Smart Meter</option>
        </select><br><br>

        <label>Phase Code:</label>
        <select name="code">
            <option>011</option>
            <option>022</option>
            <option>033</option>
            <option>044</option>
            <option>055</option>
            <option>066</option>
            <option>077</option>
            <option>088</option>
            <option>099</option>
        </select><br><br>

        <label>Bill Type:</label>
        <select name="billtype">
            <option>Normal</option>
            <option>Industrial</option>
        </select><br><br>

        <label>Days:</label>
        <input type="text" value="30" readonly><br><br>

        <label>Note:</label>
        <p>By default, the bill is calculated for 30 days only.</p>

        <input type="submit" value="Submit">
    </form>
</body>
</html>
