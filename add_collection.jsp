<%--
  Created by IntelliJ IDEA.
  User: fishe
  Date: 4/24/2019
  Time: 5:57 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Create a new collection</title>
</head>
<body>
<%
    java.sql.Connection conn;
    java.sql.Statement st;
    Class.forName("com.mysql.jdbc.Driver");
    conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost/thehub", "root", "2342");
    st = conn.createStatement();
%>
<%
    String current_user_id = request.getParameter("user_id");
    String collection_name = request.getParameter("new_collection_name");
    String qr_collection = "INSERT INTO thehub.collections(user_id, collection_name) VALUES(\""+current_user_id+"\",\""+collection_name+"\");";
    st.executeUpdate(qr_collection);
    response.sendRedirect("index.jsp");
%>
</body>
</html>
