<%@ page import="java.sql.*" %>

<html>
<head>
    <title> Student Management System </title>
    <link rel="stylesheet" href="mystyle.css"/>
</head>
<body>
    <center>
        <h1> View records of the student </h1>
        <br>
        <%
        String un = (String) session.getAttribute("un");
        if (un == null) {
            response.sendRedirect("index.jsp");
        } 
        %>

        <textarea rows="10" cols="60" disabled="true" style="text-align: center;" >
            <%
            try 
            {
                Class.forName("com.mysql.cj.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/sms_19july23";
                Connection con = DriverManager.getConnection(url, "root", "amishaka");
                String sql = "SELECT rno, name, marks FROM sms";
                PreparedStatement pst = con.prepareStatement(sql);
                ResultSet rs = pst.executeQuery();

                // Adding titles to the data with extra spaces for alignment
                out.print  ("RNO \tNAME   \tMARKS         \n");

                while(rs.next())
                {
                    out.print(rs.getString(1) + "\t" + rs.getString(2) + "\t" + rs.getString(3) + "\n");
                }

                con.close();
            }
            catch(SQLException e)
            {
                out.println("sql issue " + e);
            }
            catch(ClassNotFoundException e)
            {
                out.println("Class not found: " + e);
            }
            %>
        </textarea>

        <br><br>
        <form method="POST">
            <button class="login-button" type="submit" name="btn">Back</button>
        </form>
        <% if (request.getParameter("btn") != null) {
            response.sendRedirect("sms.jsp");
            return;
        } %>
    </center>
</body>
</html>
