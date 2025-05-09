<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.*,javax.servlet.http.*" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>Calculate Bill</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #e6f7ff; padding: 20px; }
        .container { max-width: 600px; margin: auto; background: white; padding: 20px; border-radius: 10px; box-shadow: 0px 0px 10px #aaa; }
        .form-group { margin-bottom: 15px; }
        label { display: block; font-weight: bold; }
        input[type="text"], select { width: 100%; padding: 8px; margin-top: 5px; }
        .btn { background-color: #007BFF; color: white; padding: 10px 20px; border: none; cursor: pointer; border-radius: 5px; }
        .btn:hover { background-color: #0056b3; }
    </style>
    
</head>
<body>
<div class="container">
    <h2>Calculate Electricity Bill</h2>
    
    <form  action="calculatebill" method="post">
        <div class="form-group">
            <label for="meter_no">Meter Number</label>
            <select name="meter_no" id="meter_no" required onchange="fetchCustomerInfo(this.value)">
                <option value="">Select</option>
                <%
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ebs", "root", "Server@321");
                        Statement st = conn.createStatement();
                        ResultSet rs = st.executeQuery("SELECT meter_no FROM customer");
                        while (rs.next()) {
                            out.println("<option value='" + rs.getString("meter_no") + "'>" + rs.getString("meter_no") + "</option>");
                        }
                        conn.close();
                    } catch (Exception e) {
                        out.println("Error: " + e.getMessage());
                    }
                %>
            </select>
        </div>

        <div class="form-group">
            <label>Name</label>
            <span id="name_display">Auto-filled</span>
        </div>

        <div class="form-group">
            <label>Address</label>
            <span id="address_display">Auto-filled</span>
        </div>

        <div class="form-group">
            <label for="units">Units Consumed</label>
            <input type="text" name="units" required />
        </div>

        <div class="form-group">
            <label for="month">Month</label>
            <select name="month" required>
                <%
                    String[] months = {"January","February","March","April","May","June","July","August","September","October","November","December"};
                    for (String month : months) {
                        out.println("<option value='" + month + "'>" + month + "</option>");
                    }
                %>
            </select>
        </div>

        <button type="submit" class="btn">Submit</button>
        <a href="project.jsp" class="btn" style="background-color:#6c757d; margin-left:10px;">Cancel</a>
    </form>
</div>

<script>
    function fetchCustomerInfo(meter_no) {
        fetch('getcustomerinfo.jsp?meter_no=' + meter_no)
            .then(response => response.json())
            .then(data => {
                document.getElementById('name_display').textContent = data.name || "N/A";
                document.getElementById('address_display').textContent = data.address || "N/A";
            });
    }
</script>
</body>
</html>
