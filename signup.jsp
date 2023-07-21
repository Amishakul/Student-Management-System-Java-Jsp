<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<html>
<head>
        <title> Student Management System </title>
        <link rel="stylesheet" href="mystyle.css"/>
        
</head>
<body>
<center>
         
          <h1> SignUp Page 💻 </h1>
          
          <a href="index.jsp">
            <button class="login-button" type="submit" name="btn2">Already Registered Users</button>
            <br>
          </a>
          <br>
          <form method="POST">
                  <div class="name-container2">
                   <input type="text" name="un" placeholder="enter username" required/>
                   <br><br>
                   <input type="password" name="pw1" placeholder="enter password" required >
                   <br><br>
                   <input type="password" name="pw2" placeholder="confirm password" required >
                   <br><br>
                   <button class="signup-button" type="submit" name="btn">Sign Up</button>
                   <br><br>
                   
                   </div>
       </form>

       <% 
       if (request.getParameter("btn") != null)
       { 
             String un = request.getParameter("un").trim();  // Trim the username

             if (un.length() == 0)
             {
                 %>
                 <script>
                     setTimeout(function() {
                         alert("You did not enter a name");
                     }, 10);
                 </script>
                 <%
             }
             else if (un.length() < 3)
             {
                 %>
                 <script>
                     setTimeout(function() {
                         alert("Name should be a minimum of 3 characters");
                     }, 10);
                 </script>
                 <%
             }
             else if (!un.matches("[A-Za-z]+"))
             {
                 %>
                 <script>
                     setTimeout(function() {
                         alert("Name should contain only alphabets");
                     }, 10);
                 </script>
                 <%
             }
             else
             {
                 String pw1 = request.getParameter("pw1");
                 String pw2 = request.getParameter("pw2");

                 if (!pw1.equals(pw2))
                 {
                     %>
                     <script>
                         setTimeout(function() {
                             alert("Passwords did not match");
                         }, 10);
                     </script>
                     <%
                     return;
                 }
                 try 
                 {
                     DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
                     String url = "jdbc:mysql://localhost:3306/sms_19july23";
                     Connection con = DriverManager.getConnection(url, "root", "amishaka");
                     String sql = "INSERT INTO user VALUES (?, ?)";
                     PreparedStatement pst = con.prepareStatement(sql);
                     pst.setString(1, un);
                     pst.setString(2, pw1);
                     pst.executeUpdate();
                     response.sendRedirect("index.jsp");
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
       }
       %>

        
</center>
</body>
</html>
