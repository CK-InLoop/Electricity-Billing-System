package electricity.billing.system;

import java.sql.*;

public class Conn {
    Connection c;
    Statement s;

    public Conn() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Load MySQL driver
            c = DriverManager.getConnection("jdbc:mysql://localhost:3306/ebs", "root", "Server@321");
            s = c.createStatement();
        } catch (Exception e) {
            System.out.println("Database connection failed: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
