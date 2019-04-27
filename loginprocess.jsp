<%-- 
    Document   : loginprocess
    Created on : Apr 27, 2019, 1:14:19 PM
    Author     : Cole
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
  java.sql.Connection conn;
  java.sql.Statement st;
  java.sql.ResultSet rs;
  
  Class.forName("com.mysql.jdbc.Driver");
  conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost/library_catalog","root","123456");
  st = conn.createStatement();

  String username = request.getParameter("");
  String password = request.getParameter("");

  String checkUser = "SELECT username FROM users WHERE username = '"+ username +"' AND password = '"+ password +"'" ;
  rs = st.executeQuery(checkUser);
  if (rs.next() ) {
      session.setAttribute("users", username);
      response.sendRedirect("home.jsp");
  }
  else {
      response.sendRedirect("index.jsp?c");
  }
%>
