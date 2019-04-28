<%--
  Created by IntelliJ IDEA.
  User: shiel
  Date: 4/20/2019
  Time: 8:57 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Delete Task</title>
</head>
<body>
<%
    java.sql.Connection conn;                 // Connection: A connection with a specific database.
    java.sql.Statement st;                   // Statement: The object used for executing a static SQL statement and returning the results it produces.
    // mysql database to work with your project. Go to,
    // Your project -> right click -> properties -> Libraries -> Compiler tab -> Add library -> select "MySQL JDBC Driver" library -> Ok
    Class.forName("com.mysql.jdbc.Driver"); //to connect mysql database
    conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost/thehub", "root", "2342");  //connection with database.. demo: db name, username:root, password: " "
    st = conn.createStatement();
    String qr;

    if (request.getParameter("sure").equals("Cancel")) {
        response.sendRedirect("index.jsp");
    } else {
        //read in all ids to delete
        String[] todo_ids = request.getParameterValues("thingsToDelete");

        if (todo_ids == null) {
            response.sendRedirect("index.jsp");
        }
        else {
            for (String id : todo_ids) {
                qr = "DELETE FROM todo WHERE todo_id = " + id + ";";
                st.executeUpdate(qr);
            }
            response.sendRedirect("index.jsp");
        }
    }


%>
</body>
</html>
