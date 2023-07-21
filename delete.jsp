<%@ page import="java.sql.*" %>

<html>
<head>
    <title>Student Management System</title>
    <link rel="stylesheet" href="mystyle.css"/>
    <script>
        function confirmDelete() {
            return confirm("Are you sure you want to delete?");
        }
    </script>
</head>
<body>
    <center>
        
        <h1>Delete student record </h1>
        <br><br>
    <%
        String un = (String) session.getAttribute("un");
        if (un == null) {
            response.sendRedirect("index.jsp");
        } 
    %>
        <form method="POST">
            
            <input type="number" name="rno" placeholder="Enter your rno" required min="1">
            <br><br>
            <button class="login-button" type="submit" name="btn">Delete</button>
            <br><br>
            
        </form>
          
          <form method="POST">
            <button class="login-button" type="submit" name="back">Back</button>
            <br><br>
          </form>

        <%
            if (request.getParameter("btn") != null) {
                String rnoStr = request.getParameter("rno");
                
                try {
                    int rno = Integer.parseInt(rnoStr); // Convert the String to an integer
                    DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
                    String url = "jdbc:mysql://localhost:3306/sms_19july23";
                    Connection con = DriverManager.getConnection(url, "root", "amishaka");
                    String sql = "DELETE FROM sms WHERE rno=?";
                    PreparedStatement pst = con.prepareStatement(sql);
                    pst.setInt(1, rno);
                    int r = pst.executeUpdate();

                    out.println(r + " record deleted");
                    con.close();
                } catch (SQLException e) {
                    out.println("SQL issue: " + e);
                } catch (NumberFormatException e) {
                    out.println("Invalid input for rno. Please enter a valid number.");
                }
            }
        %>
        <%
        if (request.getParameter("back") != null) {
            response.sendRedirect("sms.jsp");
            return;
        }
    %>
    </center>
</body>
</html>
