<%--
  Created by IntelliJ IDEA.
  User: fishe
  Date: 4/20/2019
  Time: 2:32 PM
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
    String current_user_id = request.getParameter("user_id");
    String memo_text_data = request.getParameter("memo_text");
    String collection_data = request.getParameter("collection_data");
    String current_date = (new java.util.Date()).toLocaleString();
    int collection_id = 0;
    int is_in_collection = 0;

    if (collection_data.equals("not_added_to_collection")) {
        collection_id = -1;
        is_in_collection = 0;
    }
    else if (collection_data.equals("new_collection")){
        //figure out making new collection
        //need to prompt user a new text box to enter in a collection name once clicking this option
    }
    else {
        //if none of the above are selected, the form will pass the collection_id that the user selected
        collection_id = Integer.parseInt(collection_data);
    }

    String qr_memo = "INSERT INTO thehub.memos(user_id, journal_cdata, date_created, collection_id, is_in_collection) " +
            "VALUES ('" + current_user_id + "','" + memo_text_data + "','" + current_date + "','" + collection_id + "','" + is_in_collection + "');";
    int execute = st.executeUpdate(qr_memo);

    response.sendRedirect("index.jsp");
%>

</body>
</html>
