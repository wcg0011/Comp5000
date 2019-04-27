<%--
  Created by IntelliJ IDEA.
  User: fishe
  Date: 4/25/2019
  Time: 9:46 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    java.sql.Connection conn;
    java.sql.ResultSet rs_memo;
    java.sql.ResultSet rs_collections;
    java.sql.Statement st;
    java.sql.Statement st1;
    Class.forName("com.mysql.jdbc.Driver");
    conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost/thehub", "root", "1234");
    st = conn.createStatement();
    st1 = conn.createStatement();
%>
<%
    String this_memo_id = request.getParameter("memo_id");
    String this_collection_id = request.getParameter("change_collection");
    String qr_change_collection = "UPDATE memos SET collection_id = '"+this_collection_id+"' WHERE memo_id = '"+this_memo_id+"';";
    st.executeUpdate(qr_change_collection);

    response.sendRedirect("index.jsp");
%>

</body>
</html>
