<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Pay Bill</title>
    <style>
        /* General body styles */
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f9;
            color: #333;
            margin: 0;
            padding: 0;
        }

        /* Centered container for the page */
        .container {
            max-width: 800px;
            margin: 50px auto;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        /* Title section */
        h1 {
            font-size: 28px;
            text-align: center;
            color: #4CAF50;
            margin-bottom: 20px;
        }

        /* Form container */
        form {
            margin-bottom: 20px;
        }

        /* Section headers */
        .section-header {
            font-size: 18px;
            font-weight: bold;
            margin-top: 20px;
            color: #4CAF50;
        }

        /* Input fields and labels */
        label {
            font-size: 14px;
            color: #555;
            margin-bottom: 10px;
            display: block;
        }

        .info {
            font-size: 16px;
            color: #555;
            margin: 10px 0;
            padding: 10px;
            background-color: #f1f1f1;
            border-radius: 5px;
        }

        /* Radio buttons and labels for month selection */
        .radio-group {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            margin: 10px 0;
        }

        .radio-group input[type="radio"] {
            margin-right: 10px;
        }

        /* Submit buttons */
        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
            margin-top: 10px;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }

        /* Back button styling */
        .back-button {
            background-color: #f44336;
            color: white;
            padding: 10px 20px;
            border: none;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
            text-decoration: none;
            display: inline-block;
            margin-top: 10px;
            text-align: center;
        }

        .back-button:hover {
            background-color: #d32f2f;
        }
    </style>
</head>
<body>

    <!-- Main Container -->
    <div class="container">
        <h1>Electricity Bill Payment</h1>

        <!-- Display Meter Information -->
        <p class="info"><strong>Meter Number:</strong> ${meter}</p>
        <p class="info"><strong>Name:</strong> ${name}</p>

        <!-- Month Selection (using radio buttons) -->
        <form action="PayBill" method="get">
            <div class="section-header">Select Month:</div>
            <div class="radio-group">
                <c:forEach var="m" items="${months}">
                    <div>
                        <input type="radio" name="month" value="${m}" 
                            <c:if test="${m == month}">checked</c:if> />
                        <label>${m}</label>
                    </div>
                </c:forEach>
            </div>
            <input type="submit" value="Select Month" />
        </form>

        <!-- Display Bill Information -->
        <p class="info"><strong>Units:</strong> ${units}</p>
        <p class="info"><strong>Total Bill:</strong> ${totalbill}</p>
        <p class="info"><strong>Status:</strong> 
            <span style="color: ${status == 'Paid' ? 'green' : 'red'}">${status}</span>
        </p>

        <!-- Button to pay the bill -->
        <form action="PayBill" method="post">
            <input type="hidden" name="month" value="${month}" />
            <input type="submit" name="action" value="Pay" />
        </form>

        <!-- Back to Project button -->
        <a href="project.jsp" class="back-button">Back to Project</a>
    </div>

</body>
</html>
