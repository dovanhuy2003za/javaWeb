<%-- 
    Document   : database
    Created on : Sep 27, 2024, 1:11:09 PM
    Author     : Huy pc
--%>



<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@page import="java.sql.PreparedStatement" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
        table {
            width: 50%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
    </style>
    </head>
    <body>
 
        <h2>Enter User Details</h2>
    <form action="database.jsp" method="post">
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" required><br><br>

        <label for="pass">Password:</label>
        <input type="password" id="pass" name="pass" required><br><br>

        <input type="submit" value="Submit">
    </form>
        <%
    String name = request.getParameter("name");
    String pass = request.getParameter("pass");
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs=null;
    try {
        // Load the MySQL JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Connect to the database (replace with your actual DB credentials)
        String url = "jdbc:mysql://localhost:3307/user";
        String user = "root";
        String password = "";
        conn = DriverManager.getConnection(url, user, password);

        // Insert data into the database
        String sql = "INSERT INTO acounts (name, pass) VALUES (?, ?)";
        ps = conn.prepareStatement(sql);
        ps.setString(1, name);
        ps.setString(2, pass);

        int rows = ps.executeUpdate();

        if (rows > 0) {
            out.println("<h3>User information saved successfully!</h3>");
        } else {
            out.println("<h3>Error saving user information.</h3>");
        }
    } catch (Exception e) {
        out.println("<h3>Error: " + e.getMessage() + "</h3>");
        e.printStackTrace();
    } 
%>
    <h2>Data from Database:</h2>
    <%  
        try {
            
            String sql1 = "SELECT id, name, pass FROM acounts";
            ps = conn.prepareStatement(sql1);
            rs=ps.executeQuery();
            out.println("<table>");
            out.println("<tr><th>ID</th><th>Username</th><th>Pasword</th></tr>");

        // Loop through result set and print data in table rows
            while (rs.next()) {
            int id = rs.getInt("id");
            String username = rs.getString("name");
            String pass1 = rs.getString("pass");
            out.println("<tr><td>" + id + "</td><td>" + username + "</td><td>" + pass1 + "</td></tr>");
            }
        
        // End table
            out.println("</table>");
        } catch (Exception e) {
            e.printStackTrace();
            out.println("Error: " + e.getMessage());
        }finally {
        // Close connections
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException se) {
            se.printStackTrace();
        }
        }
         
           
            
     %>  
     <form action="/WebApplication1/NewServlet" method="get">
         <input type="submit" value="hienthi" >
     </form>
    </body>
</html>
