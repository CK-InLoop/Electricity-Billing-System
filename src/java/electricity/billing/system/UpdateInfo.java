package electricity.billing.system;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import javax.servlet.http.HttpSession;

public class UpdateInfo extends HttpServlet {
@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Instead of getting meter_no from request, get it from session
        HttpSession session = request.getSession(false);
        String meterNo = null;
        if (session != null) {
            meterNo = (String) session.getAttribute("meter_no");
        }
        if (meterNo == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Fetch customer details from the database using meter number
        try {
            Conn c = new Conn();
            ResultSet rs = c.s.executeQuery("SELECT * FROM customer WHERE meter_no = '" + meterNo + "'");

            if (rs.next()) {
                // Set customer data as request attributes
                request.setAttribute("name", rs.getString("name"));
                request.setAttribute("meter_no", rs.getString("meter_no"));
                request.setAttribute("address", rs.getString("address"));
                request.setAttribute("city", rs.getString("city"));
                request.setAttribute("state", rs.getString("state"));
                request.setAttribute("email", rs.getString("email"));
                request.setAttribute("phone", rs.getString("phone"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Forward to the JSP page to display the form
        RequestDispatcher dispatcher = request.getRequestDispatcher("updateinfo.jsp");
        dispatcher.forward(request, response);
    }
@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Instead of getting meter_no from request, get it from session
        HttpSession session = request.getSession(false);
        String meterNo = null;
        if (session != null) {
            meterNo = (String) session.getAttribute("meter_no");
        }
        if (meterNo == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        try {
            Conn c = new Conn();
            // Update the customer information in the database
            c.s.executeUpdate("UPDATE customer SET address = '" + address + "', city = '" + city + "', state = '" + state + "', email = '" + email + "', phone = '" + phone + "' WHERE meter_no = '" + meterNo + "'");

            // Redirect to a success page or show a success message
            response.sendRedirect("project.jsp"); // Redirect to a success page

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("project.jsp"); // Redirect to a failure page
        }
    }
}
