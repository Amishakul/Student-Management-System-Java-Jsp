<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<html>
<head>
    <title> Student Management System </title>
    <link rel="stylesheet" href="mystyle.css"/>
</head>
<body>
    <center>
        <h1> Login Page 💻 </h1>
        <br><br>
        <a href="signup.jsp">
            <button class="signup-button" type="submit" name="btn2">New Users</button>
            <br>
        </a>
        <br><br>
        <form method="POST">
            <div class="name-container">
                <input type="text" name="un" placeholder="enter username" required/>
                <br><br>
                <input type="password" name="pw" placeholder="enter password" required>
                <br><br>
                <button class="login-button" type="submit" name="btn">Login</button>
            </div>
        </form>

        <% 
        if (request.getParameter("btn") != null)
        {
            String un = request.getParameter("un");
            String pw = request.getParameter("pw");
            try 
            {
                DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
                String url = "jdbc:mysql://localhost:3306/sms_19july23";
                Connection con = DriverManager.getConnection(url, "root", "amishaka");
                String sql = "select * from user where un = ? and pw = ?";
                PreparedStatement pst = con.prepareStatement(sql);
                pst.setString(1, un);
                pst.setString(2, pw);
                ResultSet rs = pst.executeQuery();
                if (rs.next()) {
                    session.setAttribute("un", un);
                    response.sendRedirect("sms.jsp");
                } else {
                    %>
                    <script>
                        setTimeout(function() {
                            alert("Invalid login");
                        }, 10);
                    </script>
                    <%
                }
                con.close();
            }
            catch(SQLException e)
            {
                %>
                <script>
                    setTimeout(function() {
                        alert("SQL issue: <%= e.getMessage() %>");
                    }, 10);
                </script>
                <%
            }
        }
        %>
    </center>
</body>
</html>
