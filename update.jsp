<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<html>
<head>
    <title>Student Management System</title>
    <link rel="stylesheet" href="mystyle.css"/>
    <script>
        // Function to validate the form before submission
        function validateForm() {
            var name = document.getElementsByName('name')[0].value;
            var marks = document.getElementsByName('marks')[0].value;

            // Client-side validation for name: only alphabets, no spacing at start, and minimum 3 characters
            if (!name.match(/^[A-Za-z]{3,}$/)) {
                alert("Please enter a valid name (minimum 3 characters, alphabets only, no spacing at start).");
                return false;
            }

            // Client-side validation for marks: positive integers only
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
    <h1>Update student record</h1>
    <% String un = (String) session.getAttribute("un");
        if (un == null) {
            response.sendRedirect("index.jsp");
        } 
    %>

    <form method="POST" onsubmit="return validateForm();">
        <br>
        <input type="number" name="rno" placeholder="Enter rno" required />
        <br><br>
        <input type="text" name="name" placeholder="Enter your name" required />
        <br><br>
        <input type="number" name="marks" placeholder="Enter your marks" required min="0" step="1" />
        <br><br>
        <button class="login-button" type="submit" name="btn">Update</button>
        <br><br>
    </form>

    <form method="POST">
        <button class="login-button" type="submit" name="back">Back</button>
        <br><br>
    </form>

    <% if (request.getParameter("btn") != null) {
        String rnoString = request.getParameter("rno");
        String name = request.getParameter("name");
        String marksString = request.getParameter("marks");

        try {
            int rno = Integer.parseInt(rnoString);
            int marks = Integer.parseInt(marksString);

            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/sms_19july23";
            Connection con = DriverManager.getConnection(url, "root", "amishaka");
            String sql = "update sms set name=?, marks=? where rno=?";

            // Server-side validation for name: no spacing at the start and minimum 3 characters
            if (name.trim().length() < 3 || !name.matches("^[A-Za-z]*$")) {
                out.println("Please enter a valid name (minimum 3 characters, alphabets only, no spacing at start).");
            } else {
                PreparedStatement pst = con.prepareStatement(sql);
                pst.setString(1, name);
                pst.setInt(2, marks);
                pst.setInt(3, rno);

                int rc = pst.executeUpdate();
                out.println(rc + " records updated ");
            }

            con.close();
        } catch (ClassNotFoundException e) {
            out.println("Database driver not found");
        } catch (SQLException e) {
            out.println("Issue with database operation: " + e.getMessage());
        } catch (NumberFormatException e) {
            out.println("Please check the roll no again.");
        }
    } %>

    <% if (request.getParameter("back") != null) {
        response.sendRedirect("sms.jsp");
        return;
    } %>
</center>
</body>
</html>
