package electricity.billing.system;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class MeterInfo extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String meter = request.getParameter("meter");
        String location = request.getParameter("location");
        String type = request.getParameter("type");
        String code = request.getParameter("code");
        String billtype = request.getParameter("billtype");
        String days = "30";

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ebs", "root", "Server@321");

            String query = "INSERT INTO meter_info (meter_no, meter_location, meter_type, phase_code, bill_type, days) VALUES (?, ?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(query);
            ps.setString(1, meter);
            ps.setString(2, location);
            ps.setString(3, type);
            ps.setString(4, code);
            ps.setString(5, billtype);
            ps.setString(6, days);
            ps.executeUpdate();
            
            ps.executeUpdate();

            // Set encoding and content type
            response.setContentType("text/html; charset=UTF-8");

            response.getWriter().println("<!DOCTYPE html>");
            response.getWriter().println("<html><head><title>Success</title>");
            response.getWriter().println("<style>");
            response.getWriter().println("  body { font-family: Arial, sans-serif; text-align: center; margin-top: 50px; }");
            response.getWriter().println("  .btn { background-color: #4CAF50; color: white; padding: 12px 24px;");
            response.getWriter().println("         border: none; border-radius: 8px; font-size: 16px; cursor: pointer; transition: 0.3s; }");
            response.getWriter().println("  .btn:hover { background-color: #45a049; }");
            response.getWriter().println("</style></head><body>");

            response.getWriter().println("<h2>Meter Info Added Successfully ✅</h2><br>");
            response.getWriter().println("<form action='project.jsp' method='get'>");
            response.getWriter().println("<button type='submit' class='btn'>Back to Dashboard</button>");
            response.getWriter().println("</form>");

            response.getWriter().println("</body></html>");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
