<%-- 
    Document   : themBuuKien
    Created on : Oct 9, 2024, 3:17:38 PM
    Author     : Huy pc
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm Bưu Kiện</title>
</head>
<body>
    <h2>Thêm Bưu Kiện</h2>

    <form action="InsertBKServlet" method="Post">
        <table>
            <tr>
                <td>Mã Bưu Kiện:</td>
                <td><input type="text" name="MaBK" required></td>
            </tr>
            <tr>
                <td>Tên Bưu Kiện:</td>
                <td><input type="text" name="TenBK" required></td>
            </tr>
            
            <tr>
                <td>Mã Địa Chỉ Gửi:</td>
                <td><input type="text" name="MaDCGui" required></td>
            </tr>
            <tr>
                <td>Mã Địa Chỉ Nhận:</td>
                <td><input type="text" name="MaDCNhan" required></td>
            </tr>
        </table>
        <br>
        <input type="submit" value="Thêm Bưu Kiện">
    </form>

    <h3>Danh sách Địa Chỉ</h3>
    <table border="1">
        <tr>
            <th>Mã Địa Chỉ</th>
            <th>Tên tỉnh/thành</th>
            <th>Tên quận/huyện</th>
            <th>Tên xã/phường</th>
        </tr>

        <%
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");

        
                String url = "jdbc:mysql://localhost:3307/baikt";
                String user = "root";
                String password = "";
                conn = DriverManager.getConnection(url, user, password);

                String query = "SELECT * FROM DiaChi";
                ps = conn.prepareStatement(query);
                rs = ps.executeQuery();

                while (rs.next()) {
                    String maDC = rs.getString("MaDC");
                    String tinh = rs.getString("TinhThanh");
                    String qh = rs.getString("QuanHuyen");
                     String xp = rs.getString("XaPhuong");
        %>
        <tr>
            <td><%= maDC %></td>
            <td><%= tinh %></td>
            <td><%= qh %></td>
            <td><%= xp %></td>
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
