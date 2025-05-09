package electricity.billing.system;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class PayBill extends HttpServlet {
    @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    HttpSession session = request.getSession(false);
    
    if (session == null || session.getAttribute("meter_no") == null) {
        response.sendRedirect("login.jsp"); // redirect to login if session is missing
        return;
    }

    String meter = (String) session.getAttribute("meter_no");  // Retrieve meter_no from session
    if (meter == null) {
        response.sendRedirect("login.jsp"); // If meter_no is null, redirect to login
        return;
    }

    String month = request.getParameter("month");
    if (month == null) {
        month = "January"; // Default month if none is selected
    }

    String[] months = {"January", "February", "March", "April", "May", "June", 
                       "July", "August", "September", "October", "November", "December"};
    request.setAttribute("months", months);
    request.setAttribute("month", month);
    request.setAttribute("meter", meter);  // Passing meter to JSP

    try {
        Conn c = new Conn();
        // Retrieve customer info based on meter_no
        ResultSet rs = c.s.executeQuery("SELECT * FROM customer WHERE meter_no = '" + meter + "'");
        if (rs.next()) {
            request.setAttribute("name", rs.getString("name"));
        }

        // Retrieve billing info for the selected month
        rs = c.s.executeQuery("SELECT * FROM bill WHERE meter_no = '" + meter + "' AND month = '" + month + "'");
        if (rs.next()) {
            request.setAttribute("units", rs.getString("units"));
            request.setAttribute("totalbill", rs.getString("totalbill"));
            request.setAttribute("status", rs.getString("status"));
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    RequestDispatcher rd = request.getRequestDispatcher("paybill.jsp");
    rd.forward(request, response);
}


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("meter_no") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String meter = (String) session.getAttribute("meter_no");
        String month = request.getParameter("month");

        if (month != null) {
            try {
                Conn c = new Conn();
                // Mark bill as paid for the selected month
                c.s.executeUpdate("UPDATE bill SET status='Paid' WHERE meter_no='" + meter + "' AND month='" + month + "'");
            } catch (Exception e) {
                e.printStackTrace();
            }
            response.sendRedirect("paytm.jsp"); // Redirect to payment page after successful payment
        } else {
            response.sendRedirect("project.jsp"); // If no month, go back to project page
        }
    }
}
