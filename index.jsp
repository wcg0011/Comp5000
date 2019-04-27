<%-- 
    Document   : index
    Created on : Apr 27, 2019, 12:53:00 PM
    Author     : Cole
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>
            The Hub
        </title> 
    </head>
    <body>
        <h1>The Hub</h1><br/>
        <form action="login.jsp">
           <%-- Username: <input type="text" name="username"/><br/>
            Password: <input type="password" name="password"/><br/> --%>
            <input type="submit" value="Log in"/>  
        </form>
        <br/> <br/>
        <form action="signup.jsp">
            <%--First Name: <input type="text" name="FN"/><br/>
            Last Name: <input type="text" name="LN"/><br/>
            Username: <input type="text" name="username"/><br/>
            Password: <input type="password" name="password"/><br/> --%>
            <input type="submit" value="Sign Up"/>
        </form>
        
        <%
            if (request.getParameter("a") != null) {
                %>
                <p>Username found. Please login to continue</p>
                <%
            }
            else if (request.getParameter("b") != null) {
                %>
                <p>Please login or sign up to continue</p>
                <%
            }
             else if (request.getParameter("c") != null) {
                %>
                <p>Username/password is incorrect</p>
                <%
            }
            
            
        %>
    </body>
</html>

