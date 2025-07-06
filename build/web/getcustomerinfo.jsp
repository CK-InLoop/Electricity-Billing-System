<%@ page import="java.sql.*" %>
<%@ page contentType="application/json" %>
<%
    String meter = request.getParameter("meter_no");
    String json = "{}";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ebs", "root", "Server@321");
        PreparedStatement ps = conn.prepareStatement("SELECT name, address FROM customer WHERE meter_no = ?");
        ps.setString(1, meter);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            json = "{\"name\":\"" + rs.getString("name") + "\",\"address\":\"" + rs.getString("address") + "\"}";
        }
        conn.close();
    } catch (Exception e) {
        json = "{\"error\":\"" + e.getMessage() + "\"}";
    }
    out.print(json);
%>
