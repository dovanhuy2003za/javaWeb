<%-- 
    Document   : xemDiaChi
    Created on : Oct 9, 2024, 3:25:53 PM
    Author     : Huy pc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Xem Địa Chỉ</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        h2 {
            color: #333;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
            color: #333;
        }
        tr:nth-child(even){
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #e9e9e9;
        }
    </style>
</head>
<body>
    <h2>Danh sách Địa Chỉ</h2>

    <table>
        <tr>
            <th>Mã Địa Chỉ</th>
            <th>Tỉnh Thành</th>
            <th>Quận/Huyện</th>
            <th>Xã/Phường</th>
            <th>Số Bưu Kiện Gửi</th>
            <th>Số Bưu Kiện Nhận</th>
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

                // Truy vấn để lấy thông tin địa chỉ cùng với số lượng bưu kiện gửi và nhận
                String sql = "SELECT dc.MaDC, dc.TinhThanh, dc.QuanHuyen, dc.XaPhuong, " +
                             "IFNULL(gui.SoBuuKienGui, 0) AS SoBuuKienGui, " +
                             "IFNULL(nhan.SoBuuKienNhan, 0) AS SoBuuKienNhan " +
                             "FROM DiaChi dc " +
                             "LEFT JOIN (SELECT MaDCGui, COUNT(*) AS SoBuuKienGui FROM BuuKien GROUP BY MaDCGui) gui " +
                             "ON dc.MaDC = gui.MaDCGui " +
                             "LEFT JOIN (SELECT MaDCNhan, COUNT(*) AS SoBuuKienNhan FROM BuuKien GROUP BY MaDCNhan) nhan " +
                             "ON dc.MaDC = nhan.MaDCNhan " +
                             "ORDER BY dc.MaDC ASC";

                ps = conn.prepareStatement(sql);
                rs = ps.executeQuery();

                while (rs.next()) {
                    String maDC = rs.getString("MaDC");
                    String tinhThanh = rs.getString("TinhThanh");
                    String quanHuyen = rs.getString("QuanHuyen");
                    String xaPhuong = rs.getString("XaPhuong");
                    int soBuuKienGui = rs.getInt("SoBuuKienGui");
                    int soBuuKienNhan = rs.getInt("SoBuuKienNhan");
        %>
        <tr>
            <td><%= maDC %></td>
            <td><%= tinhThanh %></td>
            <td><%= quanHuyen %></td>
            <td><%= xaPhuong %></td>
            <td><%= soBuuKienGui %></td>
            <td><%= soBuuKienNhan %></td>
        </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
        %>
        <tr>
            <td colspan="6" style="color:red;">Có lỗi xảy ra: <%= e.getMessage() %></td>
        </tr>
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
