<%-- 
    Document   : ptbac2
    Created on : Oct 4, 2024, 3:05:29 PM
    Author     : Huy pc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h2>Giải phương trình bậc 2: ax² + bx + c = 0</h2>
    
    <form action="ptbac2.jsp" method="get">
        a: <input type="text" name="a" /><br/>
        b: <input type="text" name="b" /><br/>
        c: <input type="text" name="c" /><br/>
        <input type="submit" value="Giải phương trình" />
    </form>

    <% 
        String aStr = request.getParameter("a");
        String bStr = request.getParameter("b");
        String cStr = request.getParameter("c");

        if (aStr != null && bStr != null && cStr != null) {
            try {
                double a = Double.parseDouble(aStr);
                double b = Double.parseDouble(bStr);
                double c = Double.parseDouble(cStr);

                if (a == 0) {
                    out.println("Đây không phải là phương trình bậc 2.");
                } else {
                    double delta = b * b - 4 * a * c;
                    if (delta > 0) {
                        double x1 = (-b + Math.sqrt(delta)) / (2 * a);
                        double x2 = (-b - Math.sqrt(delta)) / (2 * a);
                        out.println("Phương trình có 2 nghiệm phân biệt:<br/>");
                        out.println("x1 = " + x1 + "<br/>");
                        out.println("x2 = " + x2 + "<br/>");
                    } else if (delta == 0) {
                        double x = -b / (2 * a);
                        out.println("Phương trình có nghiệm kép: x = " + x);
                    } else {
                        out.println("Phương trình vô nghiệm.");
                    }
                }
            } catch (NumberFormatException e) {
                out.println("Vui lòng nhập giá trị hợp lệ.");
            }
        }
    %>
    </body>
</html>
