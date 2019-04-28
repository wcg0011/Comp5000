<%--
  Created by IntelliJ IDEA.
  User: fishe
  Date: 4/21/2019
  Time: 1:09 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>The Hub: Collections</title>
    <style>
    a {
    float:right;
    margin-right: 20px;
    /*margin-top: 20px;*/
    }
    h1,h3,a {
        display:inline;
    }
    table {
        margin: auto;
    }
    div {
        align-text:center;
    }
    /*    --------------------------------------*/
    </style>
</head>
<body>
<h1 style="margin-left:20px; margin-top: 20px;">Collections</h1>
<a href="index.jsp"><h3>Home</h3></a>

<%
    java.sql.Connection conn;
    java.sql.ResultSet rs_memo;
    java.sql.ResultSet rs_collections;
    java.sql.Statement st;
    java.sql.Statement st1;
    Class.forName("com.mysql.jdbc.Driver");
    conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost/thehub", "root", "2342");
    st = conn.createStatement();
    st1 = conn.createStatement();

    String current_user_id = "1";   // change this once login gets made
%>
<%
    String qr_collections = "SELECT * FROM collections WHERE user_id = '"+current_user_id+"';";
    rs_collections = st.executeQuery(qr_collections);
%> <div> <%
    while (rs_collections.next()) {
        %>
    <table border="1" cellpadding="5">
        <tbody>
        <tr>
            <td style="text-align: center">
                <%=rs_collections.getString("collection_name")%>
            </td>
        </tr>
        <%
            String qr_memo = "SELECT * FROM memos WHERE collection_id = '"+rs_collections.getString("collection_id")+"'";
            rs_memo = st1.executeQuery(qr_memo);
            while (rs_memo.next()){
        %><tr><td><%=rs_memo.getString("journal_cdata")%></td></tr><%
            }
            %>
        </tbody>
    </table>
    <br>
    <%
    }
%>
</div>
</body>
</html>
