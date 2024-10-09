<%-- 
    Document   : login
    Created on : Sep 20, 2024, 2:41:44 PM
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
        <div class="">
        <form action="login_html.html" method="post">
        <div class="">
          <label for="uname"><b>Username</b></label>
          <input type="text" placeholder="Enter Username" name="uname" required>
      
          <label for="psw"><b>Password</b></label>
          <input type="password" placeholder="Enter Password" name="psw" required>
      
          <button type="submit">Login</button>
          <label>
            <input type="checkbox" checked="checked" name="remember"> Remember me
          </label>
        </div>
      
        <div class="" style="background-color:#f1f1f1">
          <button type="button" class="">Cancel</button>
          <span class="">Forgot <a href="#">password?</a></span>
        </div>
      </form>
    </div>
    </body>
</html>
