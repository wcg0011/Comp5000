<%-- 
    Document   : signup
    Created on : Apr 27, 2019, 1:19:00 PM
    Author     : Cole
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sign Up</title>
    </head>
    <body>
        <h1>Sign Up</h1>
         <form action="signupprocess.jsp">
            First Name: <input type="text" name="FN"/><br/>
            Last Name: <input type="text" name="LN"/><br/>
            Username: <input type="text" name="username"/><br/>
            Password: <input type="password" name="password"/><br/>
            <input type="submit" value="Sign Up"/>
        </form>
    </body>
</html>
