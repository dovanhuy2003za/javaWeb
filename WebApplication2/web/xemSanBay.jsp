<%-- 
    Document   : xemSanBay
    Created on : Oct 10, 2024, 4:23:54 PM
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
        <h1>Thong tin san bay</h1>
        <table border="1">
        <tr>
            <th>Mã san bay</th>
            <th>Ten san bay</th>
            <th>Số chuyen bay di</th>
            <th>Số chuyen bay den</th>
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

                // Truy vấn để lấy thông tin địa chỉ cùng với số lượng bưu kiện gửi và nhận
                String sqlString="select * from sanbay";

                ps = conn.prepareStatement(sqlString);
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
        %>
      
        <%
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
                if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
            }
        %>
    </table>
    </body>
</html>
