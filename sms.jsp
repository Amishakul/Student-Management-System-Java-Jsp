<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.*, java.sql.*" %>

<html>
<head>
    <title>Student Management System</title>
    <link rel="stylesheet" href="mystyle.css"/>
</head>
<body>
    <center>
        <h1>Student Management System 🗒️</h1>
        <br>
        <%--
        The correct way to check if the "un" session attribute is not set is to use "session.getAttribute("un") == null".
        --%>
        <%
        String un = (String) session.getAttribute("un");
        if (un == null) {
            response.sendRedirect("index.jsp");
        } else {
            out.println("Welcome " + un + "\uD83D\uDE03");
        }
        %>
        <hr/>
        <br><br>
        <a href="add.jsp">
            <button class="signup-button" type="submit" name="add">Add Student Record</button>
            <br>
        </a>
        <br><br>
        <a href="update.jsp">
            <button class="signup-button" type="submit" name="update">Update Student Record</button>
            <br>
        </a>
        <br><br>
        <a href="view.jsp">
            <button class="signup-button" type="submit" name="view">View Student Record</button>
            <br>
        </a>
        <br><br>
        <a href="delete.jsp">
            <button class="signup-button" type="submit" name="delete">Delete Student Record</button>
            <br>
        </a>
        <br><br>
        <%-- The "onclick" event handler should be on the anchor tag, not on the button. --%>
        <a href="index.jsp" onclick="return confirmLogout();">
            <button class="signup-button" type="submit" name="logout">Logout</button>
            <br>
        </a>
        <br><br>
    </center>

    <script>
        function confirmLogout() {
            return confirm("Are you sure you want to logout?");
        }
    </script>
</body>
</html>
