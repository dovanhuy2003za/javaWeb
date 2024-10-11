<%-- 
    Document   : themChuyenBay
    Created on : Oct 10, 2024, 4:20:27 PM
    Author     : Huy pc
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <form action="InsertSBServlet" method="Post">
        <table>
            <tr>
                <td>Mã chuyến bay:</td>
                <td><input type="text" name="Macb" required></td>
            </tr>
            <tr>
                <td>Tên chuyến bay:</td>
                <td><input type="text" name="Tencb" required></td>
            </tr>
            
            <tr>
                <td>Nơi đi:</td>
                <td><input type="text" name="noidi" required></td>
            </tr>
            <tr>
                <td>Nơi đến:</td>
                <td><input type="text" name="noiden" required></td>
            </tr>
        </table>
        <br>
        <input type="submit" value="Thêm chuyenbay">
    </form>

    <h3>Danh sách San bay</h3>
    <table border="1">
        <tr>
            <th>Mã san bay</th>
            <th>Tên san bay</th>
            
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

                String query = "SELECT * FROM sanbay";
                ps = conn.prepareStatement(query);
                rs = ps.executeQuery();

                while (rs.next()) {
                    String masb = rs.getString("msb");
                    String tensb = rs.getString("tensb");
                   
        %>
        <tr>
            <td><%= masb %></td>
            <td><%= tensb %></td>
            
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
