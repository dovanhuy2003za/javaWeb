<%-- 
    Document   : xemBuuKien
    Created on : Oct 9, 2024, 3:19:43 PM
    Author     : Huy pc
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Xem Bưu Kiện</title>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
        }
        th {
            background-color: #f2f2f2;
            text-align: left;
        }
        .button-container {
            margin: 20px 0;    
        }
        .asd{
            padding: 20px;
        }
    </style>
</head>
<body>
    <h2>Danh sách Bưu Kiện</h2>

    <div  class="button-container">
        <form method="get" action="xemBuuKien.jsp">
            <input type="submit" name="filter" value="Gửi nội tỉnh thành">
            <input type="submit" name="reset" value="Hiển thị tất cả">
        </form>
        <form class="asd" method="get" action="xemDiaChi.jsp">
            <input type="submit" name="next" value="Xem dia chi">
        </form>
    </div>

    <table>
        <tr>
            <th>Mã Bưu Kiện</th>
            <th>Tên Bưu Kiện</th>
            <th>Nơi Gửi</th>
            <th>Nơi Nhận</th>
            
        </tr>

        <%
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            String filter = request.getParameter("filter");
            String reset = request.getParameter("reset");
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");

        
                String url = "jdbc:mysql://localhost:3307/baikt";
                String user = "root";
                String password = "";
                conn = DriverManager.getConnection(url, user, password);

                // SQL truy vấn với JOIN để lấy thông tin địa chỉ gửi và nhận
                String sql = "SELECT bk.MaBK, bk.TenBK, " +
                             "dg.TinhThanh AS TinhThanhGui, dg.QuanHuyen AS QuanHuyenGui, dg.XaPhuong AS XaPhuongGui, " +
                             "dn.TinhThanh AS TinhThanhNhan, dn.QuanHuyen AS QuanHuyenNhan, dn.XaPhuong AS XaPhuongNhan " +
                             "FROM BuuKien bk " +
                             "JOIN DiaChi dg ON bk.MaDCGui = dg.MaDC " +
                             "JOIN DiaChi dn ON bk.MaDCNhan = dn.MaDC ";

                // Nếu người dùng nhấn nút "Gửi nội tỉnh thành", thêm điều kiện lọc
                if ("Gửi nội tỉnh thành".equals(filter)) {
                    sql += "WHERE dg.TinhThanh = dn.TinhThanh ";
                }

                ps = conn.prepareStatement(sql);
                rs = ps.executeQuery();

                while (rs.next()) {
                    String maBK = rs.getString("MaBK");
                    String tenBK = rs.getString("TenBK");
                    

                    String tinhThanhGui = rs.getString("TinhThanhGui");
                    String quanHuyenGui = rs.getString("QuanHuyenGui");
                    String xaPhuongGui = rs.getString("XaPhuongGui");

                    String tinhThanhNhan = rs.getString("TinhThanhNhan");
                    String quanHuyenNhan = rs.getString("QuanHuyenNhan");
                    String xaPhuongNhan = rs.getString("XaPhuongNhan");
        %>
        <tr>
            <td><%= maBK %></td>
            <td><%= tenBK %></td>
            <td>
                <strong>Tỉnh Thành:</strong> <%= tinhThanhGui %><br>
                <strong>Quận/Huyện:</strong> <%= quanHuyenGui %><br>
                <strong>Xã/Phường:</strong> <%= xaPhuongGui %>
            </td>
            <td>
                <strong>Tỉnh Thành:</strong> <%= tinhThanhNhan %><br>
                <strong>Quận/Huyện:</strong> <%= quanHuyenNhan %><br>
                <strong>Xã/Phường:</strong> <%= xaPhuongNhan %>
            </td>
            
        </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<tr><td colspan='5'>Có lỗi xảy ra: " + e.getMessage() + "</td></tr>");
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
                if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
            }
        %>
    </table>
</body>
</html>
