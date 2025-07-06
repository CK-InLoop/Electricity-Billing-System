package electricity.billing.system;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String usertype = request.getParameter("usertype");

        // Hardcoded admin login
        if (username.equals("admin") && password.equals("admin") && usertype.equalsIgnoreCase("Admin")) {
            HttpSession session = request.getSession();
            session.setAttribute("usertype", "Admin");
            session.setAttribute("meter_no", "0"); // dummy value for admin
            response.sendRedirect(request.getContextPath() + "/project.jsp");
            return;
        }

        try {
            Conn c = new Conn();
            // Revert to fetching meter_no directly from login table
            String query = "SELECT meter_no FROM login WHERE username=? AND password=? AND user=?";
            PreparedStatement ps = c.c.prepareStatement(query);
            if (c.c == null) {
            throw new ServletException("Database connection not established.");
            }

            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, usertype);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("usertype", usertype);
                session.setAttribute("meter_no", rs.getString("meter_no"));
                response.sendRedirect(request.getContextPath() + "/project.jsp");  // Redirect to main page after login
            } else {
                request.setAttribute("error", "Invalid username or password!");
                RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                rd.forward(request, response);
            }
        } catch (Exception e) {
            throw new ServletException("Login failed", e);
        }
    }
}
