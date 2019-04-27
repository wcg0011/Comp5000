<%-- 
    Document   : login
    Created on : Apr 27, 2019, 1:16:39 PM
    Author     : Cole
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>
    <body>
        <h1>Login</h1> <br/>
        <form action="loginprocess.jsp">
            Username: <input type="text" name="username"/><br/>
            Password: <input type="password" name="password"/><br/> 
            <input type="submit" value="Log in"/>  
        </form>
    </body>
</html>
