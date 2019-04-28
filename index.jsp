<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.concurrent.TimeUnit" %>
<%@ page import="java.text.DecimalFormat" %><%--
  Created by IntelliJ IDEA.
  User: shiel
  Date: 4/20/2019
  Time: 2:33 PM
  To change this template use File | Settings | File Templates.
  Home page - to-do lists functionality
--%>
<%--To do:
    1) COMPLETE: display a list of tasks with due dates
    2) COMPLETE: update status to complete/incomplete
    3) COMPLETE: sort by overdue/not overdue
    4) COMPLETE: sort by due in next day/week/month/year
    5) COMPLETE: progress bar (percentage of tasks complete for next day/week/month/year
        [1] count number of tasks due in next time period
        [2] count number of those that are complete
        [3] create percentage of that
    6) COMPLETE: delete tasks
    7) COMPLETE: default values for new task
    8) CSS
    -apostrophe's mess crap up
    --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>The Hub: Home Page</title>
    <style>
        @media only screen and (max-width: 600px) {
            body {
                background-color: lightblue;
            }
        }
        #text {
            position: absolute; /* Sit on top of the page content */
            top: 11%;
            left: 50%;
            font-size: 22px;
            color: white;
            background-color: rgba(0, 0, 0, 0.9); /* Black background with opacity */
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

        #everythingContainer {
            float:left;
            width:90%;
            margin: 40px;
            overflow:hidden;
            /*background-color: #555555;*/
        }
        #memoContainer {
            margin-left:40px;
            min-width:575px;
            overflow:hidden;
            /*background-color: crimson;*/
            /*text-align:center;*/
        }

        #todoContainer {
            min-width: 775px;
            overflow:hidden;
            /*background-color: darkolivegreen;*/
            /*text-align:center;*/
        }

        #todosandstuff {
            /*background-color: chocolate;*/
            width: 37%;
            display:inline;
            float:left
        }

        #memosandstuff {
            /*background-color: #4CAF50;*/
            width: 37%;
            display: inline;
        }

        #progress {
            background-color: slategrey;
            border-radius: 13px;
            padding: 3px;
        }

        #progress-bar {
            background-color: aliceblue;
            height: 20px;
            border-radius: 10px;
        }

        /*    --------------------------------------*/
            table.fixed { table-layout:fixed; }
            table.fixed #td2 { overflow: hidden; }

        #collection_table {
            /*align: right;*/
            position: absolute;
            top: 100px;
            right: 50px;
        }

        #memo_tables {
            position: relative;
            top: 0;
            left: 0;
        }

        {
            box-sizing: border-box
        ;
        }

        /* Button used to open the collections form - fixed at the bottom of the page */
        .open-button {
            background-color: #555;
            color: white;
            padding: 16px 20px;
            border: none;
            cursor: pointer;
            opacity: 0.8;
            /*position: fixed;*/
            /*bottom: 23px;*/
            /*right: 28px;*/
            width: 205px;
        }

        /* The popup form - hidden by default */
        .form-popup {
            display: none;
            position: fixed;
            bottom: 0;
            right: 15px;
            border: 3px solid #f1f1f1;
            z-index: 9;
        }


        /* Add styles to the form container */
        .form-container {
            max-width: 300px;
            padding: 10px;
            background-color: white;
        }

        /* Full-width input fields */
        .form-container input[type=text], .form-container input[type=password] {
            width: 100%;
            padding: 15px;
            margin: 5px 0 22px 0;
            border: none;
            background: #f1f1f1;
        }

        /* When the inputs get focus, do something */
        .form-container input[type=text]:focus, .form-container input[type=password]:focus {
            background-color: #ddd;
            outline: none;
        }

        .form-container .btn {
            background-color: #4CAF50;
            color: white;
            padding: 16px 20px;
            border: none;
            cursor: pointer;
            width: 100%;
            margin-bottom: 10px;
            opacity: 0.8;
        }

        /* Add a red background color to the cancel button */
        .form-container .cancel {
            background-color: red;
        }

        /* Add some hover effects to buttons */
        .form-container .btn:hover, .open-button:hover {
            opacity: 1;
        }

        #hidden_table1:hover {
            background-color: blanchedalmond;
            display: block;
        }

        #hidden_table2 {
            display: none;
        }

        a {
            float:right;
            margin-right: 20px;
            margin-top: 20px;
        }
        /*    --------------------------------------*/
    </style>
    <script>
        function openForm() {
            document.getElementById("add_collection_form").style.display = "block";
        }

        function closeForm() {
            document.getElementById("add_collection_form").style.display = "none";
        }

        function openCollection() {
            document.getElementById("memos_in_collection").style.display = "block";
        }

        function closeCollection() {
            document.getElementById("memos_in_collection").style.display = "none";
        }

        function open_collection_edit() {
            document.getElementById("collection_edit").style.display = "block";
        }

        function close_collection_edit() {
            document.getElementById("collection_edit").style.display = "none";
        }

        function open_hiddentable2() {
            document.getElementById("hidden_table2").style.display = "block";
        }
    </script>
</head>
<body>
<h1>The Hub</h1>
<a href="logout.jsp"><h3>Logout</h3></a>       <!-- Logout link -->
<a href="about.jsp"><h3>About</h3></a>
<a href="settings.jsp"><h3>Settings</h3></a>
<a href="collections.jsp"><h3>Collections</h3></a>


<%
    java.sql.Connection conn;                 // Connection: A connection with a specific database.
    java.sql.ResultSet rs;                   // ResultSet: A table of data representing a database result set, which is usually generated by executing a statement that queries the database.
    java.sql.ResultSet rs1;
    java.sql.ResultSet rs_collections;
    java.sql.ResultSet rs_replies;
    java.sql.ResultSet rs_memo;
    java.sql.Statement st;                   // Statement: The object used for executing a static SQL statement and returning the results it produces.
    java.sql.Statement st1;                   // Statement: The object used for executing a static SQL statement and returning the results it produces.
    java.sql.Statement st2;                   // Statement: The object used for executing a static SQL statement and returning the results it produces.

    // mysql database to work with your project. Go to,
    // Your project -> right click -> properties -> Libraries -> Compiler tab -> Add library -> select "MySQL JDBC Driver" library -> Ok
    Class.forName("com.mysql.jdbc.Driver"); //to connect mysql database
    conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost/thehub", "root", "2342");  //connection with database.. demo: db name, username:root, password: " "
    st = conn.createStatement();
    st1 = conn.createStatement();
    st2 = conn.createStatement();

    String qr;
    int user_id = -1;

    if (session.getAttribute("uname") == null) {
        response.sendRedirect("loginAndSignup.jsp");
    }

    //check if session we created exists or not
    else if (session.getAttribute("uname") != null) {
        qr = "SELECT user_id FROM users WHERE username = '" + session.getAttribute("uname") + "';";
        rs = st.executeQuery(qr);
        if (rs.next()) {
            user_id = rs.getInt("user_id");
        }
        rs.close();

        int is_shown_here = 0;
        qr = "SELECT is_shown FROM users WHERE user_id = " + user_id + ";";
        rs = st.executeQuery(qr);
        if (rs.next()) {
            is_shown_here = rs.getInt("is_shown");
        }
        rs.close();


//___________________________________________________________________________________________________________
//___________________________________________________________________________________________________________
//___________________________________________________________________________________________________________
//___________________________________________________________________________________________________________
//___________________________________________________________________________________________________________
//beginning of todos
//___________________________________________________________________________________________________________
//___________________________________________________________________________________________________________
//___________________________________________________________________________________________________________
//___________________________________________________________________________________________________________
//___________________________________________________________________________________________________________
        if (is_shown_here == 0 || is_shown_here == 1) {

            //https://www.w3schools.com/howto/howto_js_progressbar.asp
            //get ready to show percentage of tasks complete for specified time period
            qr = "SELECT * FROM todo WHERE user_id = " + user_id + ";";
            rs = st.executeQuery(qr);       //gets all of a user's tasks
            int total = 0;
            int complete = 0;
            String period = "";
            //if sort is "All tasks"
            if (request.getParameter("sort") == null || request.getParameter("sort").equals("1")) {
                while (rs.next()) {     //count total tasks and tasks completed to get percentage later
                    total++;
                    if (rs.getInt("is_completed") == 1) {
                        complete++;
                    }
                }
                period = "forever";
            }
            //else if sort is anything else, filter by due date to add total tasks to complete in that time period
            else {
                DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); //dateformat for use in sort cases
                java.util.Date due = new java.util.Date();
                long diff = 0;
                while (rs.next()) {
                    //total = 0;
                    //complete = 0;
                    diff = 0;
                    int todo_id = rs.getInt("todo_id");
                    qr = "SELECT due_date FROM todo WHERE todo_id = " + todo_id + ";";
                    rs1 = st1.executeQuery(qr);
                    if (rs1.next()) {
                        due = rs1.getDate("due_date");

                        if (due != null) {
                            Calendar c = Calendar.getInstance();
                            java.util.Date tomorrow = dateFormat.parse(dateFormat.format(c.getTime())); //parse tomorrow's date into usable form
                            long diffInMilli = (due.getTime() - tomorrow.getTime());
                            diff = TimeUnit.DAYS.convert(diffInMilli, TimeUnit.MILLISECONDS);      //converts difference in times to days
                        }
                        if (request.getParameter("sort").equals("2")) {
                            period = "day";
                            //get tomorrow's date
                            if (diff <= 1 && diff >= 0) { //if difference is greater than a day, remove from list by calling rs.get all of it's attributes
                                total++;
                                if (rs.getInt("is_completed") == 1) {
                                    complete++;
                                }
                            }
                        } else if (request.getParameter("sort").equals("3")) {
                            period = "week";
                            //get tomorrow's date
                            if (diff <= 7 && diff >= 0) { //if difference is greater than a day, remove from list by calling rs.get all of it's attributes
                                total++;
                                if (rs.getInt("is_completed") == 1) {
                                    complete++;
                                }
                            }
                        } else if (request.getParameter("sort").equals("4")) {
                            period = "month";
                            //get tomorrow's date
                            if (diff <= 31 && diff >= 0) { //if difference is greater than a day, remove from list by calling rs.get all of it's attributes
                                total++;
                                if (rs.getInt("is_completed") == 1) {
                                    complete++;
                                }
                            }
                        } else if (request.getParameter("sort").equals("5")) {
                            period = "year";
                            //get tomorrow's date
                            if (diff <= 365 && diff >= 0) { //if difference is greater than a day, remove from list by calling rs.get all of it's attributes
                                total++;
                                if (rs.getInt("is_completed") == 1) {
                                    complete++;
                                }
                            }
                        }
                    }
                }
            }
            //calculate the percent complete
            DecimalFormat df = new DecimalFormat("###");
            double percentComplete = ((double) complete / total) * 100;
            int tasksToGo = total - complete;
%>
<div id="everythingContainer" class="row">
<div id="todoContainer" class="column">
    <div id="todosandstuff">
        <h2>To-do List</h2>
    <div id="container" style="width: 85%;">
        <div class="progress" id="progress">
            <div class="progress-bar" id="progress-bar" role="progressbar" aria-valuenow="<%=percentComplete%>"
                 aria-valuemin="0" aria-valuemax="100" style="width:<%=percentComplete%>%">
                <span><%=df.format(percentComplete)%>%</span>
            </div>
        </div>
        <h3>Your progress bar:</h3>
        <h3>
<%--            <text>You have completed <%=df.format(percentComplete)%>% <%=period%>--%>
<%--            </text>--%>
        </h3>
        <h3>
            <text>You have <%=tasksToGo%> tasks to still complete out of <%=total%>!</text>
        </h3>
        <br/>
        <h3>For the next  <%=period%></h3>
    </div>
        <%

    qr = "SELECT * FROM todo WHERE user_id = " + user_id + ";";
    rs = st.executeQuery(qr);
%>
    <%--//__________________________________________________________________________________________--%>
    <%--//__________________________________________________________________________________________--%>
    <%--Display all uncompleted tasks--%>
    <%--        display overdue tasks first, then normal tasks--%>
    <%--        also sort tasks if necessary--%>
    <%--//__________________________________________________________________________________________--%>
    <%--//__________________________________________________________________________________________--%>
    <form>
        <text>Sort By:</text>
        <select name="sort">
            <option value="1">All Tasks</option>
            <option value="2">Due Tomorrow</option>
            <option value="3">Due in Next Week</option>
            <option value="4">Due in Next Month</option>
            <option value="5">Due in Next Year</option>
        </select>
        <input type="submit" name="sortCall" value="Sort"/>
    </form>

    <form name="createTask" method="POST">
        <input type="submit" name="makeTask" value="Create a new task"/>
    </form>
    <%--        The idea here is to send our sort criteria to a javascript function that will determine which tasks fall under the sort
                then it will come back and print those tasks in a table. javascript was chosen because it more easily handles dates
                however, i am stumped as to how to use it. i'm going to give it a go in java--%>
    <%--things to do still--%>
    <div style="float:left;">
        <div style="float:left; display:inline; width:50%;min-width:300px;">
            <table style="; border: 1px solid black; width:95%;">
                <tbody>
                <tr>
                    <th><h3>To-do List:</h3></th>
                </tr>
                <form name="markComplete" Method="POST">
                    <tr>
                        <th style="border: 1px solid black;">Overdue Tasks</th>
                    </tr>
                    <tr><td> </td></tr>
                    <tr><td> </td></tr>
                    <%
                        //------------------------------------------------------------------
                        //------------------------------------------------------------------
                        //sort overdue tasks
                        //------------------------------------------------------------------
                        //------------------------------------------------------------------

                        while (rs.next()) {
                            if (rs.getInt("is_completed") != 1) {
                                int todo_id = rs.getInt("todo_id");
                                qr = "SELECT due_date FROM todo WHERE todo_id = " + todo_id + ";";
                                rs1 = st1.executeQuery(qr);
                                DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); //dateformat for use in sort cases
                                //navigate to appropriate sort option
                                if (rs1.next()) {
                                    //check for overdue first
                                    java.util.Date dued = rs1.getDate("due_date");
                                    if (dued != null) {
                                        Calendar c = Calendar.getInstance();
                                        java.util.Date tomorrow = dateFormat.parse(dateFormat.format(c.getTime())); //parse tomorrow's date into usable form
                                        long diffInMilli = (dued.getTime() - tomorrow.getTime());
                                        long diff = TimeUnit.DAYS.convert(diffInMilli, TimeUnit.MILLISECONDS);      //converts difference in times to days

                                        if (diff >= 0) { //if difference is greater than a day, remove from list by calling rs.get all of it's attributes
                                            rs.getString("task_name");
                                            rs.getString("text_data");
                                            rs.getDate("due_date");
                                            continue;
                                        }
                                    } else if (dued == null) {
                                        rs.getString("task_name");
                                        rs.getString("text_data");
                                        rs.getDate("due_date");
                                        continue;
                                    }
                                    rs1.close();
                                    //perform sort based on due date for incomplete task ids read in
                    %>
                    <%--    hidden input to get all of the user's todo_ids--%>
                    <input type="hidden" name="todo_ids" value="<%=todo_id%>"/>
                    <br/>
                    <tr>
                        <td>
                            <table border="0" style="border: 1px solid black;width:85%;">
                                <tbody>
                                <tr>
                                    <th style="border: 1px solid black;"><%=rs.getString("task_name")%>
                                    </th>
                                </tr>
                                <tr>
                                    <td><%=rs.getString("text_data")%>
                                    </td>
                                    <td>
                                        <%--                mark each box with specific todo_id to pass to markAsComplete handler--%>
                                        <input type="checkbox" name="complete<%=todo_id%>" value="complete"/>
                                    </td>
                                </tr>
                                <tr>
                                    <%
                                        java.sql.Date due = rs.getDate("due_date");
                                        if (due == null) {
                                        } else {
                                    %>
                                    <td>Due Date: <%=due%>
                                    </td>
                                    <%
                                        }
                                    %>
                                </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <%
                                }
                            }
                        }
                        //close rs and reload it with the values to iterate through for the tasks that aren't overdue
                        rs.close();
                        qr = "SELECT * FROM todo WHERE user_id = " + user_id + ";";
                        rs = st.executeQuery(qr);
                    %>
                    <br/>
                    <tr><td> </td></tr>
                    <tr><td> </td></tr>
                    <tr>
                        <th style="border: 1px solid black;">End Overdue Tasks</th>
                    </tr>
                    <%--        -------------------------------------------------------------%>
                    <%--        -------------------------------------------------------------%>
                    <%--        Break between overdue and not overdue tasks--%>
                    <%--        -------------------------------------------------------------%>
                    <%--        -------------------------------------------------------------%>
                    <%
                        //read in incomplete task ids and handle one at a time
                        String title = "All Tasks";
                        if (request.getParameter("sort") != null) {
                            switch (request.getParameter("sort")) {
                                case "1":
                                    break;
                                case "2":
                                    title = "Due Tomorrow";
                                    break;
                                case "3":
                                    title = "Due in Next Week";
                                    break;
                                case "4":
                                    title = "Due in Next Month";
                                    break;
                                case "5":
                                    title = "Due in Next Year";
                                    break;
                                default:
                                    break;
                            }
                        }
                    %>
                    <tr>
                        <%--            //--------------------------------------------------------------------%>
                        <%--            //--------------------------------------------------------------------%>
                        <%--            //display sorted tasks ( not overdue )--%>
                        <%--            //--------------------------------------------------------------------%>
                        <%--            //--------------------------------------------------------------------%>
                        <th style="border: 1px solid black;"><%=title%>
                        </th>
                    </tr>
                    <tr><td> </td></tr>
                    <tr><td> </td></tr>
                    <%
                        while (rs.next()) {
                            if (rs.getInt("is_completed") != 1) {
                                int todo_id = rs.getInt("todo_id");
                                qr = "SELECT due_date FROM todo WHERE todo_id = " + todo_id + ";";
                                rs1 = st1.executeQuery(qr);
                                DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); //dateformat for use in sort cases
                                java.util.Date due = new java.util.Date();
                                long diff = 0;
                                if (rs1.next()) {
                                    due = rs1.getDate("due_date");
                                }
                                if (due != null) {
                                    Calendar c = Calendar.getInstance();
                                    java.util.Date tomorrow = dateFormat.parse(dateFormat.format(c.getTime())); //parse tomorrow's date into usable form
                                    long diffInMilli = (due.getTime() - tomorrow.getTime());
                                    diff = TimeUnit.DAYS.convert(diffInMilli, TimeUnit.MILLISECONDS);      //converts difference in times to days
                                }
                                //navigate to appropriate sort option
                                //check for overdue first

                                //all
                                if (request.getParameter("sort") == null || request.getParameter("sort").equals("1")) {
                                    //if no sort, only filter out overdue items
                                    if (diff < 0) { //if difference is greater than a day, remove from list by calling rs.get all of it's attributes
                                        rs.getString("task_name");
                                        rs.getString("text_data");
                                        rs.getDate("due_date");
                                        continue;
                                    }
                                }
                                //day
                                else if (request.getParameter("sort").equals("2")) {
                                    //get tomorrow's date
                                    if (diff > 1 || diff < 0) { //if difference is greater than a day, remove from list by calling rs.get all of it's attributes
                                        rs.getString("task_name");
                                        rs.getString("text_data");
                                        rs.getDate("due_date");
                                        continue;
                                    }
                                }
                                //week
                                else if (request.getParameter("sort").equals("3")) {
                                    //get next week's date
                                    if (diff > 7 || diff < 0) { //if difference is greater than a week, remove from list by calling rs.get all of it's attributes
                                        rs.getString("task_name");
                                        rs.getString("text_data");
                                        rs.getDate("due_date");
                                        continue;
                                    }
                                }
                                //month
                                else if (request.getParameter("sort").equals("4")) {
                                    //get next month's date
                                    if (diff > 31 || diff < 0) { //if difference is greater than a month, remove from list by calling rs.get all of it's attributes
                                        rs.getString("task_name");
                                        rs.getString("text_data");
                                        rs.getDate("due_date");
                                        continue;
                                    }
                                }
                                //year
                                else if (request.getParameter("sort").equals("5")) {
                                    //get next years's date
                                    if (diff > 365 || diff < 0) { //if difference is greater than a year, remove from list by calling rs.get all of it's attributes
                                        rs.getString("task_name");
                                        rs.getString("text_data");
                                        rs.getDate("due_date");
                                        continue;
                                    }
                                }
                                rs1.close();
                                //perform sort based on due date for incomplete task ids read in
                    %>
                    <%--    hidden input to get all of the user's todo_ids--%>
                    <input type="hidden" name="todo_ids" value="<%=todo_id%>"/>
                    <%--            <br/>--%>
                    <tr>
                        <td>
                            <table border="0" style="border: 1px solid black; width:85%;">
                                <tbody>
                                <tr>
                                    <th style="border: 1px solid black;"><%=rs.getString("task_name")%>
                                    </th>
                                </tr>
                                <tr>
                                    <td><%=rs.getString("text_data")%>
                                    </td>
                                    <td>
                                        <%--                mark each box with specific todo_id to pass to markAsComplete handler--%>
                                        <input type="checkbox" name="complete<%=todo_id%>" value="complete"/>
                                    </td>
                                </tr>
                                <tr>
                                    <%
                                        java.sql.Date dued = rs.getDate("due_date");
                                        if (dued == null) {
                                        } else {
                                    %>
                                    <td>Due Date: <%=dued%>
                                    </td>
                                    <%
                                        }
                                    %>
                                </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <%
                            }
                        }
                    %>
                    <br/>
                    <tr><td> </td></tr>
                    <tr><td> </td></tr>
                    <tr>
                        <th style="border: 1px solid black;">End To-Do List</th>
                    </tr>
                    <tr>
                        <td>
                            <input type="submit" name="markChecked" value="Mark Selected Tasks as Complete"/> <br/>
                            <input type="submit" name="deleteTasks" value="Delete Selected Tasks"/>
                        </td>
                    </tr>
                </form>
                </tbody>
            </table>
        </div>

        <%--//take care of completed tasks--%>
        <div style="float:left; display:inline; width:50%;min-width:300px;">
            <br/>
            <table style="float:left; border: 1px solid black; width:95%;">
                <tbody>
                <tr>
                    <th><h3>Completed Tasks:</h3></th>
                </tr>
                <form name="markIncomplete" Method="POST">
                    <%
                        qr = "SELECT * FROM todo WHERE user_id = " + user_id + ";";
                        rs = st.executeQuery(qr);
                        //read in incomplete task ids and handle one at a time
                        //String title = "All Tasks";
                        if (request.getParameter("sort") != null) {
                            switch (request.getParameter("sort")) {
                                case "1":
                                    break;
                                case "2":
                                    title = "Completed Tasks due Tomorrow";
                                    break;
                                case "3":
                                    title = "Completed Tasks due in Next Week";
                                    break;
                                case "4":
                                    title = "Completed Tasks due in Next Month";
                                    break;
                                case "5":
                                    title = "Completed Tasks due in Next Year";
                                    break;
                                default:
                                    break;
                            }
                        }
                    %>
                    <tr>
                        <%--            //--------------------------------------------------------------------%>
                        <%--            //--------------------------------------------------------------------%>
                        <%--            //display sorted tasks--%>
                        <%--            //--------------------------------------------------------------------%>
                        <%--            //--------------------------------------------------------------------%>
                        <th style="border: 1px solid black;"><%=title%>
                        </th>
                    </tr>
                    <tr><td> </td></tr>
                    <tr><td> </td></tr>
                    <%
                        while (rs.next()) {
                            if (rs.getInt("is_completed") == 1) {
                                int todo_id = rs.getInt("todo_id");
                                qr = "SELECT due_date FROM todo WHERE todo_id = " + todo_id + ";";
                                rs1 = st1.executeQuery(qr);
                                DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); //dateformat for use in sort cases
                                java.util.Date due = new java.util.Date();
                                long diff = 0;
                                if (rs1.next()) {
                                    due = rs1.getDate("due_date");
                                }
                                if (due != null) {
                                    Calendar c = Calendar.getInstance();
                                    java.util.Date tomorrow = dateFormat.parse(dateFormat.format(c.getTime())); //parse tomorrow's date into usable form
                                    long diffInMilli = (due.getTime() - tomorrow.getTime());
                                    diff = TimeUnit.DAYS.convert(diffInMilli, TimeUnit.MILLISECONDS);      //converts difference in times to days
                                }
                                //navigate to appropriate sort option
                                //check for overdue first

                                //all
                                if (request.getParameter("sort") == null || request.getParameter("sort").equals("1")) {
                                }
                                //day
                                else if (request.getParameter("sort").equals("2")) {
                                    //get tomorrow's date
                                    if (diff > 1 || diff < 0) { //if difference is greater than a day, remove from list by calling rs.get all of it's attributes
                                        rs.getString("task_name");
                                        rs.getString("text_data");
                                        rs.getDate("due_date");
                                        continue;
                                    }
                                }
                                //week
                                else if (request.getParameter("sort").equals("3")) {
                                    //get next week's date
                                    if (diff > 7 || diff < 0) { //if difference is greater than a day, remove from list by calling rs.get all of it's attributes
                                        rs.getString("task_name");
                                        rs.getString("text_data");
                                        rs.getDate("due_date");
                                        continue;
                                    }
                                }
                                //month
                                else if (request.getParameter("sort").equals("4")) {
                                    //get next month's date
                                    if (diff > 31 || diff < 0) { //if difference is greater than a day, remove from list by calling rs.get all of it's attributes
                                        rs.getString("task_name");
                                        rs.getString("text_data");
                                        rs.getDate("due_date");
                                        continue;
                                    }
                                }
                                //year
                                else if (request.getParameter("sort").equals("5")) {
                                    //get next years's date
                                    if (diff > 365 || diff < 0) { //if difference is greater than a day, remove from list by calling rs.get all of it's attributes
                                        rs.getString("task_name");
                                        rs.getString("text_data");
                                        rs.getDate("due_date");
                                        continue;
                                    }
                                }
                                rs1.close();
                                //perform sort based on due date for incomplete task ids read in
                    %>
                    <%--    hidden input to get all of the user's todo_ids--%>
                    <input type="hidden" name="todo_ids" value="<%=todo_id%>"/>
                    <tr>
                        <td>
                            <table border="0" style="border: 1px solid black; width:85%;">
                                <tbody>
                                <tr>
                                    <th style="border: 1px solid black;"><%=rs.getString("task_name")%>
                                    </th>
                                </tr>
                                <tr>
                                    <td><%=rs.getString("text_data")%>
                                    </td>
                                    <td>
                                        <%--                mark each box with specific todo_id to pass to markAsComplete handler--%>
                                        <input type="checkbox" name="complete<%=todo_id%>" value="incomplete"/>
                                    </td>
                                </tr>
                                <tr>
                                    <%
                                        java.sql.Date dued = rs.getDate("due_date");
                                        if (dued == null) {
                                        } else {
                                    %>
                                    <td>Due Date: <%=dued%>
                                    </td>
                                    <%
                                        }
                                    %>
                                </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <%
                            }
                        }
                    %>
                    <br/>
                    <tr/>
                    <tr><td> </td></tr>
                    <tr><td> </td></tr>
                    <tr>
                        <th style="border: 1px solid black;">End Completed Tasks</th>
                    </tr>
                    <tr>
                        <td>
                            <input type="submit" name="markCheckedIn" value="Mark Selected Tasks as Incomplete"/> <br/>
                            <input type="submit" name="deleteTasks" value="Delete Selected Tasks"/>
                        </td>
                    </tr>
                </form>
                </tbody>
            </table>
        </div>
    </div>
    </div>
    <%--//__________________________________________________________________________________________--%>
    <%--//__________________________________________________________________________________________--%>
    <%--provide option to create tasks--%>
    <%--//__________________________________________________________________________________________--%>
    <%--//__________________________________________________________________________________________--%>


        <%
    //create a form to input a new task
    if (request.getParameter("makeTask") != null) {
%>
    <div id="overlay">
        <div id="text">
            <form name="taskForm" method="POST">
                Task Name: <input maxlength="49" type="text" name="taskName"> <br/>
                Task Description: <input maxlength="119" type="text" name="taskDescription"> <br/>
                Due Date: <input type="date" name="dueDate"> <br/>
                <input type="submit" name="finalizeCreation" value="Make Task">
                <input type="submit" name="finalizeCreation" value="Cancel">
            </form>
        </div>
    </div>
        <%
    }
    //if user decides to create a task, set session attributes and navigate to NewTask.jsp
    //String finalize = request.getParameter("finalizeCreation");
    if (request.getParameter("finalizeCreation") != null) {
        session.setAttribute("finalize", request.getParameter("finalizeCreation"));
        session.setAttribute("dueDate", request.getParameter("dueDate"));
        session.setAttribute("taskName", request.getParameter("taskName"));
        session.setAttribute("taskDescription", request.getParameter("taskDescription"));
        response.sendRedirect("NewTask.jsp?user_id=" + user_id);
    }

    //__________________________________________________________________________________________
    //__________________________________________________________________________________________
    //if user decides to delete task, send todo_id to DeleteTask.jsp
    //__________________________________________________________________________________________
    //__________________________________________________________________________________________
    if (request.getParameter("deleteTasks") != null) {
        String[] todo_ids = request.getParameterValues("todo_ids");
%>
    <div id="overlay">
        <div id="text">
            <form name="toDelete" method="POST" action="DeleteTask.jsp"><%
                for (String id : todo_ids) {
                    String temp = request.getParameter("complete" + id);
                    if (temp != null) {
            %>
                <input type="hidden" name="thingsToDelete" value="<%=id%>"/>
                <%
                        }
                    }%>
                Are you sure you want to delete the selected tasks? <br/>
                <input type="submit" name="sure" value="Continue">
                <input type="submit" name="sure" value="Cancel">
            </form>
        </div>
    </div>
        <%
    }

    //__________________________________________________________________________________________
    //__________________________________________________________________________________________
    //if user decides to mark task as complete, send todo_id to MarkAsComplete.jsp
    //__________________________________________________________________________________________
    //__________________________________________________________________________________________
    if (request.getParameter("markChecked") != null) {
        String[] todo_ids = request.getParameterValues("todo_ids");
%>
    <div id="overlay">
        <div id="text">
            <form name="toMark" method="POST" action="MarkAsComplete.jsp"><%
                for (String id : todo_ids) {
                    String temp = request.getParameter("complete" + id);
                    if (temp != null) {
            %>
                <input type="hidden" name="markAsDone" value="<%=id%>"/>
                <%
                        }
                    }%>
                Are you sure you want to mark the selected tasks as complete? <br/>
                <input type="submit" name="sure" value="Continue">
                <input type="submit" name="sure" value="Cancel">
            </form>
        </div>
    </div>
        <%
    }

    //__________________________________________________________________________________________
    //__________________________________________________________________________________________
    //if user decides to mark task as incomplete, send todo_id to MarkAsIncomplete.jsp
    //__________________________________________________________________________________________
    //__________________________________________________________________________________________
    if (request.getParameter("markCheckedIn") != null) {
        String[] todo_ids = request.getParameterValues("todo_ids");
%>
    <div id="overlay">
        <div id="text">
            <form name="toMarkIn" method="POST" action="MarkAsIncomplete.jsp"><%
                for (String id : todo_ids) {
                    String temp = request.getParameter("complete" + id);
                    if (temp != null) {
            %>
                <input type="hidden" name="markAsUndone" value="<%=id%>"/>
                <%
                        }
                    }%>
                Are you sure you want to mark the selected tasks as incomplete? <br/>
                <input type="submit" name="sure" value="Continue">
                <input type="submit" name="sure" value="Cancel">
            </form>
        </div>
    </div>
    </div>

        <%
        }

    }
    //___________________________________________________________________________________________________________
//___________________________________________________________________________________________________________
//___________________________________________________________________________________________________________
//___________________________________________________________________________________________________________
//___________________________________________________________________________________________________________
//end of todos/start of memos
//___________________________________________________________________________________________________________
//___________________________________________________________________________________________________________
//___________________________________________________________________________________________________________
//___________________________________________________________________________________________________________
//___________________________________________________________________________________________________________
    if (is_shown_here == 0 || is_shown_here == 2) {
        %>
    <%--  enter in a new memo here --%>

<div id="memoContainer" class="column">
    <div id="memosandstuff" >
        <h2>Memos</h2>
        <textarea maxlength="239" rows="4" cols="50" name="memo_text" form="memoform"></textarea>
        <form name="memo" action="memo.jsp" method="post" id="memoform">
            <select name="collection_data">
                <option value="not_added_to_collection">Post without adding to a collection</option>
                <%
                    //creating the drop down menu with all the collections
                    String qr_collections = "SELECT * FROM collections WHERE user_id = '" + user_id + "';";
                    rs_collections = st1.executeQuery(qr_collections);
                    while (rs_collections.next()) {
                %>
                <option value="<%=rs_collections.getInt("collection_id")%>">
                    <%=rs_collections.getString("collection_name")%>
                </option>
                <%
                    }
                %>
            </select>
            <br>
            <input type="hidden" name="user_id" value="<%=user_id%>"/>
            <input type="submit" value="Add New Memo"/>
        </form>


            <%
    String qr_memo = "SELECT * FROM memos WHERE user_id = " + user_id + ";";
    rs_memo = st.executeQuery(qr_memo);

    rs_memo.afterLast();    //display memos in date order this way
    while (rs_memo.previous()) {
%>
        <%--  table of all the memos--%>
        <div id="memo_tables">
            <table class="fixed" style="border: solid black 1px" cellpadding="1">
                <tbody>
                <col width="200px">
                <col width="100px">
                <tr>
                    <td><%=rs_memo.getString("date_created")%>
                    </td>
                    <td border="0" cellpadding="0">  <!-- Delete memo entry button form-->
                        <form name="delete_memo" action="delete_memo.jsp">
                            <input type="submit" name="delete_memo" value="Delete">
                            <input type="hidden" name="memo_id" value="<%=rs_memo.getString("memo_id")%>">
                        </form>
                    </td>
                </tr>
                <tr>
                    <td><%=rs_memo.getString("journal_cdata")%>
                    </td>
                    <td>
                        <%
                            //from here to line 111 has to do with changing the current collection of the memo
                            String current_collection_name = "Not in Collection";
                            rs_collections.beforeFirst();
                            while (rs_collections.next()) {
                                if (rs_collections.getInt("collection_id") == rs_memo.getInt("collection_id")) {
                                    current_collection_name = rs_collections.getString("collection_name");
                                }
                            }
                        %>
                        Collection:
                        <br>
                        <%--            form to change the collection. submits the form when user changes the select value. kinda neat. --%>
                        <form name="change_collection" action="change_collection.jsp">
                            <select name="change_collection" onchange="this.form.submit()">
                                <option><%=current_collection_name%>
                                </option>
                                <%
                                    rs_collections.beforeFirst();
                                    while (rs_collections.next()) {
                                        if (!rs_collections.getString("collection_name").equals(current_collection_name)) {
                                %>
                                <option value="<%=rs_collections.getInt("collection_id")%>">
                                    <%=rs_collections.getString("collection_name")%>
                                </option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                            <input type="hidden" name="memo_id" value="<%=rs_memo.getInt("memo_id")%>">
                        </form>
                    </td>
                </tr>
                <%
                    //here to line 135 is displaying a reply.
                    //only creates a new table row if the current memo_id is in the reply table
                    String qr_replies = "SELECT * FROM replies WHERE memo_id = '" + rs_memo.getString("memo_id") + "';";
                    rs_replies = st2.executeQuery(qr_replies);

                    if (rs_replies.next() != false) {
                        if (rs_memo.getString("memo_id").equals(rs_replies.getString("memo_id"))) {
                            rs_replies.beforeFirst();
                            while (rs_replies.next()) {


                %>
                <tr>
                    <td>
                        <%=rs_replies.getString("reply_text")%>
                    </td>
                </tr>
                <%
                            }
                        }
                    }
                %>
                <tr>
                    <form action="reply.jsp">
                        <td><input type="text" name="reply_text"></td>
                        <td><input type="submit" value="Reply"></td>
                        <input type="hidden" name="replied_memo" value="<%=rs_memo.getInt("memo_id")%>">
                        <input type="hidden" name="user_id" value="<%=user_id%>">
                    </form>
                </tr>
                </tbody>
            </table>
        </div>
            <%
    }
%>
        <%-- Here begins the collection table--%>
        <%--  dude i tried to get that hover to display memos in a collection but it aint workin --%>
        <%--  its impossible --%>
            <%
    //get all collections that match the user ID
    String qr_collections2 = "SELECT * FROM collections WHERE user_id = '" + user_id + "';";
    rs_collections = st.executeQuery(qr_collections2);
%>
        <div id="collection_table"><%
            while (rs_collections.next()) {
        %>
            <table class="fixed" border="1" cellpadding="5">
                <tbody>
                <col width="200px">
                <tr>
                    <td align="center">
                        <%--    this div was me trying to get the memos to display on hover --%>
                        <div id="hidden_table1" onmouseover="open_hiddentable2()">
                            <%=rs_collections.getString("collection_name")%>
                        </div>
                    </td>
                </tr>
                <%
                    //get all memos within the current collection
                    String qr_memo2 = "SELECT * FROM memos WHERE collection_id = '" + rs_collections.getString("collection_id") + "'";
                    rs_memo = st1.executeQuery(qr_memo2);
                    while (rs_memo.next()) {
                %>
                <tr>
                    <div id="td2">
                        <td><%=rs_memo.getString("journal_cdata")%>
                        </td>
                    </div>
                </tr>
                <br><%
                    }
                %>
                <%--      again here lies stuff from the hover feature. delete if you cant figure it out either --%>
                <%--      <div id="hidden_table2">--%>
                <%--      <div id="td2">--%>
                <%--        <%=rs_memo.getString("journal_cdata")%>--%>
                <%--      </div>--%>
                <%--      </div>--%>

                <%
                    }
                %>
                </tbody>
            </table>
            <br>
            <button class="open-button" onclick="openForm()">Add new collection</button>
        </div>
<%--</body>--%>

<%--this popup is the adding of a new collection --%>
<div class="form-popup" id="add_collection_form">
    <form action="add_collection.jsp" class="form-container">
        <h1 style="font-size: 20px">Create a new collection</h1>
        <input type="text" placeholder="Enter Collection Name" name="new_collection_name" required>
        <input type="hidden" name="user_id" value="<%=user_id%>">
        <button type="submit" class="btn">Create</button>
        <button type="submit" class="btn cancel" onclick="closeForm()">Cancel</button>
    </form>
</div>
</div>
</div>
</div>
<%
        }

    }
%>
</body>
</html>
