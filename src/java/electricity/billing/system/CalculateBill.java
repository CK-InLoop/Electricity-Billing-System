package electricity.billing.system;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

public class CalculateBill extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String meter = request.getParameter("meter_no");
        String unitsStr = request.getParameter("units");
        String month = request.getParameter("month");

        int unitConsumed;
        int totalBill = 0;

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
            unitConsumed = Integer.parseInt(unitsStr);

            // Connect to database
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ebs", "root", "Server@321");

            // Fetch tax details
            String taxQuery = "SELECT * FROM tax";
            Statement taxStmt = conn.createStatement();
            ResultSet taxRs = taxStmt.executeQuery(taxQuery);

            if (taxRs.next()) {
                totalBill += unitConsumed * Integer.parseInt(taxRs.getString("cost_per_unit"));
                totalBill += Integer.parseInt(taxRs.getString("meter_rent"));
                totalBill += Integer.parseInt(taxRs.getString("service_charge"));
                totalBill += Integer.parseInt(taxRs.getString("service_tax"));
                totalBill += Integer.parseInt(taxRs.getString("swacch_bharat_cess"));
                totalBill += Integer.parseInt(taxRs.getString("fixed_tax"));
            }

            // Insert into bill table
            String insertQuery = "INSERT INTO bill (meter_no, month, units, totalbill, status) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(insertQuery);
            ps.setString(1, meter);
            ps.setString(2, month);
            ps.setInt(3, unitConsumed);
            ps.setInt(4, totalBill);
            ps.setString(5, "Not Paid");

            int rowsInserted = ps.executeUpdate();

            if (rowsInserted > 0) {
                out.println("<script type='text/javascript'>");
                out.println("alert('Customer Bill Updated Successfully');");
                out.println("window.location = 'project.jsp';");
                out.println("</script>");
            } else {
                out.println("<h3>Error: Unable to insert bill record.</h3>");
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h3>Error: " + e.getMessage() + "</h3>");
        }
    }
}
