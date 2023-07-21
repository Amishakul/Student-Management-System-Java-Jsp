<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<html>
<head>
    <title>Student Management System</title>
    <link rel="stylesheet" href="mystyle.css"/>
    <script>
        function validateForm() {
            var name = document.getElementsByName('name')[0].value;
            var marks = document.getElementsByName('marks')[0].value;

            if (!name.match(/^[A-Za-z]{3,}$/)) {
                alert("Please enter a valid name (minimum 3 characters, alphabets only, no spacing at start).");
                return false;
            }

            if (marks < 0 || isNaN(marks) || marks.indexOf('.') !== -1) {
                alert("Please enter a valid positive integer for 'marks'.");
                return false;
            }

            return true;
        }
    </script>
</head>
<body>
<center>
    <h1>Add student record</h1>
    <%
        String un = (String) session.getAttribute("un");
        if (un == null) {
            response.sendRedirect("index.jsp");
        } 
    %>

    <form method="POST" onsubmit="return validateForm();">
        <br>
        <input type="number" name="rno" placeholder="Enter rno" required  />
        <br><br>
        <input type="text" name="name" placeholder="Enter your name" required />
        <br><br>
        <input type="number" name="marks" placeholder="Enter your marks" required min="0" step="1" />
        <br><br>
        <button class="login-button" type="submit" name="btn">Add</button>

        <br><br>
    </form>

    <form method="POST">
        <button class="login-button" type="submit" name="back">Back</button>
        <br><br>
    </form>

    <%
        if (request.getParameter("btn") != null) {
            String rnoString = request.getParameter("rno");
            String name = request.getParameter("name");
            String marksString = request.getParameter("marks");

            try {
                int rno = Integer.parseInt(rnoString);
                int marks = Integer.parseInt(marksString);

                Class.forName("com.mysql.cj.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/sms_19july23";
                Connection con = DriverManager.getConnection(url, "root", "amishaka");

                // Server-side validation for name: no spacing at the start and minimum 3 characters
                if (name.trim().length() < 3 || !name.matches("^[A-Za-z]*$")) {
                    out.println("Please enter a valid name (minimum 3 characters, alphabets only, no spacing at start).");
                } else {
                    String sql = "INSERT INTO sms (rno, name, marks) VALUES (?, ?, ?)";
                    PreparedStatement pst = con.prepareStatement(sql);
                    pst.setInt(1, rno);
                    pst.setString(2, name);
                    pst.setInt(3, marks);

                    pst.executeUpdate();
                    out.println("Your response is successfully submitted. Thank you");
                }

                con.close();
            } catch (ClassNotFoundException e) {
                out.println("Database driver not found");
            } catch (SQLException e) {
                out.println("Issue with database operation: " + e.getMessage());
            } catch (NumberFormatException e) {
                out.println("Please enter a valid number for 'rno' and 'marks'.");
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
