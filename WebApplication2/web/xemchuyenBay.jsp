<%-- 
    Document   : xemchuyenBay
    Created on : Oct 10, 2024, 4:27:36 PM
    Author     : Huy pc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Thongtin chuyen bay</h1>
         <table border="1">
        <tr>
            <th>Mã chuyen bay</th>
            <th>Ten chyen bay bay</th>
            <th>Noi di </th>
            <th>Noi den </th>
        </tr>
         <%
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");

        
                String url = "jdbc:mysql://localhost:3307/qlsb";
                String user = "root";
                String password = "";
                conn = DriverManager.getConnection(url, user, password);

                String query = "SELECT * FROM chuyenbay";
                ps = conn.prepareStatement(query);
                rs = ps.executeQuery();

                while (rs.next()) {
                    String macb = rs.getString("macb");
                    String tencb = rs.getString("tencb");
                    String noidiString=rs.getString("noidi");
                    String noidenString=rs.getString("noiden");
        %>
        <tr>
            <td><%= macb %></td>
            <td><%= tencb %></td>
            <td><%= noidiString %></td>
            <td><%= noidenString %></td>
        </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            }
        %>
        
        </table>
    </body>
</html>
