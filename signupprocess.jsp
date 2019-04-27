<%-- 
    Document   : signupprocess
    Created on : Apr 27, 2019, 1:21:30 PM
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
  String FN = request.getParameter("");
  String LN = request.getParameter("");
  
  String checkUser = "SELECT username FROM users WHERE username = '"+ username +"'";
  rs = st.executeQuery(checkUser);
  if (rs.next() ) {
      response.sendRedirect("index.jsp?a");
  }
  else {
      session.setAttribute("users", username);
      String addUser = "INSERT INTO users (fname, lname, username, password) " +
              "VALUES ('"+ FN +"', '"+ LN +"','"+username+"', '"+ password +"')";
      st.executeUpdate(addUser);
      response.sendRedirect("home.jsp");
  }
%>