<%--
  Created by IntelliJ IDEA.
  User: fishe
  Date: 4/23/2019
  Time: 5:38 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Delete Memo</title>
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
    String current_memo_id = request.getParameter("memo_id");
    String qr_memo = "DELETE FROM memos WHERE memo_id = " + current_memo_id + ";";
    st.executeUpdate(qr_memo);
    response.sendRedirect("index.jsp");
%>
</body>
</html>
