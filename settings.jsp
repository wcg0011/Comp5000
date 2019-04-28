<%--
  Created by IntelliJ IDEA.
  User: shiel
  Date: 4/27/2019
  Time: 12:19 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>The Hub: Settings</title>
    <style>
        #text {
            position: absolute; /* Sit on top of the page content */
            top: 50%;
            left: 50%;
            font-size: 25px;
            color: white;
            background-color: rgba(0, 0, 0, 0.7); /* Black background with opacity */
            transform: translate(-50%, -50%);
            -ms-transform: translate(-50%, -50%);
        }

        h1 {
            display: inline;
            margin-top: 20px;
            margin-left: 20px;
            align:center;
        }
        h3 {
            display:inline;
        }
        a {
            float:right;
            margin-right: 20px;
            margin-top: 20px;
        }

        div {
            margin: 40px;
        }
    </style>
</head>
<body>
<a style="float:right; display:inline;" href="index.jsp"><h3>Home</h3></a>
<a style="float:right; display:inline;" href="about.jsp"><h3>About</h3></a>
<h1>Settings</h1>
<%
    //we need password change functionality and view functionality
    //password first
    java.sql.Connection conn;                 // Connection: A connection with a specific database.
    java.sql.ResultSet rs;                   // ResultSet: A table of data representing a database result set, which is usually generated by executing a statement that queries the database.
    java.sql.ResultSet rs1;
    java.sql.Statement st;                   // Statement: The object used for executing a static SQL statement and returning the results it produces.
    java.sql.Statement st1;                   // Statement: The object used for executing a static SQL statement and returning the results it produces.
    // mysql database to work with your project. Go to,
    // Your project -> right click -> properties -> Libraries -> Compiler tab -> Add library -> select "MySQL JDBC Driver" library -> Ok
    Class.forName("com.mysql.jdbc.Driver"); //to connect mysql database
    conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost/thehub", "root", "2342");  //connection with database.. demo: db name, username:root, password: " "
    st = conn.createStatement();
    st1 = conn.createStatement();
    String qr;
%>
<div>
<h3>Hello, <%=session.getAttribute("uname")%>
</h3>
<br/><br/>
<form>
    <input type="submit" name="changePass" value="Change Password"/>
</form>
<% if (request.getParameter("a") != null) {
%>
<text>Please enter a new password that is not blank.</text> <br/>
<%
    } %>
<form>
    <select name="views">
        <option value="0">View Todo List and Memos</option>
        <option value="1">View only Todo Lists</option>
        <option value="2">View only Memos</option>
    </select>
    <input type="submit" name="updateView" value="Change View"/>
</form>
<%
    if (request.getParameter("changePass") != null) {
%>
<div id="overlay">
    <div id="text">
        <form>
            <text>Enter Current Password:</text>
            <input type="password" name="currPass">
            <text>Enter New Password:</text>
            <input type="password" name="newPass"> <br/>
            <input type="submit" name="pushThatPass" value="Confirm">
            <input type="submit" name="cancelPass" value="Cancel">
        </form>
    </div>
</div>
<%
    }
    if (request.getParameter("cancelPass") != null) {
        response.sendRedirect("settings.jsp");
    } else if (request.getParameter("pushThatPass") != null) {
        qr = "SELECT user_id FROM users WHERE username = '" + session.getAttribute("uname") + "';";
        rs1 = st1.executeQuery(qr);
        int user_id_now = 0;
        if (rs1.next()) {
            user_id_now = rs1.getInt("user_id");
        }
        rs1.close();
        qr = "SELECT password FROM users WHERE user_id = " + user_id_now + ";";
        rs = st.executeQuery(qr);
        String oldPass = "";
        if (rs.next()) {
            oldPass = rs.getString("password");
        }
        if (!oldPass.equals(request.getParameter("currPass"))) {
%>
<text>Current passwords do not match. Please try again.</text>
<%
} else {
    if (request.getParameter("newPass").equals("")) {
        response.sendRedirect("settings.jsp?a=1");
    } else {
        rs.close();
        qr = "UPDATE users SET password = \"" + request.getParameter("newPass") + "\" WHERE user_id = " + user_id_now + ";";
        st.executeUpdate(qr);
%>
<text>Password has been updated.</text>
<%
            }
        }
    }
    //Now update settings to show todos, memos, or both
    //0 is both, 1 is only todos, 2 is only memos
    if (request.getParameter("updateView") != null) {
        qr = "SELECT user_id FROM users WHERE username = '" + session.getAttribute("uname") + "';";
        rs1 = st1.executeQuery(qr);
        int user_id_now = 0;
        if (rs1.next()) {
            user_id_now = rs1.getInt("user_id");
        }
        rs1.close();
        qr = "UPDATE users SET is_shown = " + request.getParameter("views") + " WHERE user_id = " + user_id_now + ";";
        st.executeUpdate(qr);
%>
<text>View has been updated.</text>
<%
    }
%>
</div>

</body>
</html>
