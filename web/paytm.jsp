<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.net.URLEncoder" %>
<html>
<head>
    <title>Paytm Payment</title>
</head>
<body>
    <h2>Redirecting to Paytm Payment...</h2>
    <iframe src="https://paytm.com/online-payments" width="100%" height="500px"></iframe>
    <form action="PayBillServlet" method="get">
        <input type="hidden" name="meter" value="<%= request.getParameter("meter") %>">
        <button type="submit">Back</button>
    </form>
</body>
</html>
