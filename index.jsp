<%--
  Created by IntelliJ IDEA.
  User: fishe
  Date: 4/20/2019
  Time: 2:05 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>Productivity Hub</title>
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


    String current_user_id = "1";   //get this later once login.jsp has been made
  %>

  <form name="memo" action="memo.jsp" method="post">
    <input type="text" name="memo_text"/> <br>
    <select name="collection_data">
      <option value="not_added_to_collection">Post without adding to a collection</option>
      <option value="new_collection">Make New Collection</option>
      <%
        String qr_collections = "SELECT * FROM collections WHERE user_id = '"+current_user_id+"';";
        rs_collections = st1.executeQuery(qr_collections);
        while (rs_collections.next()) {
          %> <option value="<%=rs_collections.getInt("collection_id")%>">
          <%=rs_collections.getString("collection_name")%></option><%
        }
      %>
    </select>
    <br>
    <input type="hidden" name="user_id" value="<%=current_user_id%>"/>
    <input type="submit"/>
  </form>
  <%
    String qr_memo = "SELECT * FROM memos WHERE user_id = '"+current_user_id+"';";
    rs_memo = st.executeQuery(qr_memo);

    rs_memo.afterLast();    //display memos in date order this way
    while (rs_memo.previous()){
  %>
    <table border="1" cellpadding="5">
      <tbody>
        <tr>
          <td><%=rs_memo.getString("date_created")%></td>
        </tr>
        <tr>
          <td><%=rs_memo.getString("journal_cdata")%></td>
        </tr>
      </tbody>
    </table>
    <br>
  <%
    }
  %>

  </body>
</html>
