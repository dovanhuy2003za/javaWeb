/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

/**
 *
 * @author Huy pc
 */
@WebServlet(urlPatterns = {"/InsertBKServlet"})
public class InsertBKServlet extends HttpServlet {
    private static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String DB_URL = "jdbc:mysql://localhost:3307/baikt";
    private static final String DB_USER = "root"; // Thay đổi nếu cần
    private static final String DB_PASSWORD = ""; 
  
   

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        // Nhận dữ liệu từ form
        String maBK = request.getParameter("MaBK");
        String tenBK = request.getParameter("TenBK");
        String maDCGui = request.getParameter("MaDCGui");
        String maDCNhan = request.getParameter("MaDCNhan");
        Connection conn = null;
        PreparedStatement psCheck = null;
        PreparedStatement psInsert = null;
        ResultSet rsCheck = null;

        try {
            // Tải Driver JDBC
            Class.forName(JDBC_DRIVER);

            // Kết nối đến CSDL
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Kiểm tra sự tồn tại của MaDCGui và MaDCNhan
            String sqlCheck = "SELECT COUNT(*) AS count FROM DiaChi WHERE MaDC = ?";
            psCheck = conn.prepareStatement(sqlCheck);

            // Kiểm tra MaDCGui
            psCheck.setString(1, maDCGui);
            rsCheck = psCheck.executeQuery();
            int countGui = 0;
            if (rsCheck.next()) {
                countGui = rsCheck.getInt("count");
            }
            rsCheck.close();

            // Kiểm tra MaDCNhan
            psCheck.setString(1, maDCNhan);
            rsCheck = psCheck.executeQuery();
            int countNhan = 0;
            if (rsCheck.next()) {
                countNhan = rsCheck.getInt("count");
            }
            rsCheck.close();

            // Nếu một trong hai không tồn tại, báo lỗi
            if (countGui == 0 || countNhan == 0) {
                String error = "";
                if (countGui == 0 && countNhan == 0) {
                    error = "Mã Địa Chỉ Gửi (MaDCGui) và Mã Địa Chỉ Nhận (MaDCNhan) không tồn tại.";
                } else if (countGui == 0) {
                    error = "Mã Địa Chỉ Gửi (MaDCGui) không tồn tại.";
                } else {
                    error = "Mã Địa Chỉ Nhận (MaDCNhan) không tồn tại.";
                }
                request.setAttribute("errorMessage", error);
                request.getRequestDispatcher("themBuuKien.jsp").forward(request, response);
                return;
            }

            // Kiểm tra xem MaBK đã tồn tại chưa (tùy chọn)
            String sqlCheckMaBK = "SELECT COUNT(*) AS count FROM BuuKien WHERE MaBK = ?";
            PreparedStatement psCheckMaBK = conn.prepareStatement(sqlCheckMaBK);
            psCheckMaBK.setString(1, maBK);
            ResultSet rsCheckMaBK = psCheckMaBK.executeQuery();
            if (rsCheckMaBK.next() && rsCheckMaBK.getInt("count") > 0) {
                rsCheckMaBK.close();
                psCheckMaBK.close();
                request.setAttribute("errorMessage", "Mã Bưu Kiện (MaBK) đã tồn tại.");
                request.getRequestDispatcher("themBuuKien.jsp").forward(request, response);
                return;
            }
            rsCheckMaBK.close();
            psCheckMaBK.close();

            // Chèn dữ liệu vào bảng BuuKien
            String sqlInsert = "INSERT INTO BuuKien (MaBK, TenBK, MaDCGui, MaDCNhan) VALUES (?, ?, ?, ?)";
            psInsert = conn.prepareStatement(sqlInsert);
            psInsert.setString(1, maBK);
            psInsert.setString(2, tenBK);
            psInsert.setString(3, maDCGui);
            psInsert.setString(4, maDCNhan);
            
            int rowsInserted = psInsert.executeUpdate();

            if (rowsInserted > 0) {
                // Chèn thành công, chuyển hướng đến trang xemBuuKien.jsp hoặc thông báo thành công
                response.sendRedirect("xemBuuKien.jsp?success=1");
            } else {
                // Chèn không thành công
                request.setAttribute("errorMessage", "Không thể thêm Bưu Kiện. Vui lòng thử lại.");
                request.getRequestDispatcher("themBuuKien.jsp").forward(request, response);
            }

        } catch (ClassNotFoundException e) {
            // Lỗi Driver JDBC không được tìm thấy
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi Driver JDBC: " + e.getMessage());
            request.getRequestDispatcher("themBuuKien.jsp").forward(request, response);
        } catch (SQLException e) {
            // Lỗi SQL
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi SQL: " + e.getMessage());
            request.getRequestDispatcher("themBuuKien.jsp").forward(request, response);
        } finally {
            // Đóng tài nguyên
            try {
                if (rsCheck != null) rsCheck.close();
                if (psCheck != null) psCheck.close();
                if (psInsert != null) psInsert.close();
                if (conn != null) conn.close();
            } catch (SQLException ignore) {}
        }
    }

   

}
