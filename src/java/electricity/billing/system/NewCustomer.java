package electricity.billing.system;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
public class NewCustomer extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        
        String name = request.getParameter("name");
        String meter = request.getParameter("meter");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        Connection conn = null;
        PreparedStatement ps1 = null, ps2 = null;

        try {
            // Load JDBC driver and connect
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ebs", "root", "Server@321");

            // Insert into customer table
            String query1 = "INSERT INTO customer (name, meter_no, address, city, state, email, phone) VALUES (?, ?, ?, ?, ?, ?, ?)";
            ps1 = conn.prepareStatement(query1);
            ps1.setString(1, name);
            ps1.setString(2, meter);
            ps1.setString(3, address);
            ps1.setString(4, city);
            ps1.setString(5, state);
            ps1.setString(6, email);
            ps1.setString(7, phone);
            ps1.executeUpdate();

            // Insert into login table
            String query2 = "INSERT INTO login (meter_no, username, name, password, user) VALUES (?, '', ?, '', '')";
            ps2 = conn.prepareStatement(query2);
            ps2.setString(1, meter);
            ps2.setString(2, name);
            ps2.executeUpdate();

            // Redirect to Meter Info Page
            response.sendRedirect(request.getContextPath() + "/meterinfo.jsp?meter=" + meter);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try {
                if (ps1 != null) ps1.close();
                if (ps2 != null) ps2.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
}
