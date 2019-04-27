<%--
  Created by IntelliJ IDEA.
  User: fishe
  Date: 4/26/2019
  Time: 5:14 PM
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
    java.sql.Statement st;
    Class.forName("com.mysql.jdbc.Driver");
    conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost/thehub", "root", "1234");
    st = conn.createStatement();
%>
<%
    String this_memo_id = request.getParameter("replied_memo");
    String reply_text = request.getParameter("reply_text");
    String qr_add_reply = "INSERT INTO thehub.replies(memo_id, reply_text) VALUES('"+this_memo_id+"', '"+reply_text+"');";
    st.executeUpdate(qr_add_reply);

    response.sendRedirect("index.jsp");
%>
</body>
</html>
