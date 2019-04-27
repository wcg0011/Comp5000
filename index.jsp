<%--
  Created by IntelliJ IDEA.
  User: fisher
  Date: 4/20/2019 lol
  Time: 2:05 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

  <head>
    <title>Productivity Hub</title>
    <a href="collections.jsp"><p>Collections</p></a>
    <br>
  </head>
  <body>
  <%
    java.sql.Connection conn;
    java.sql.ResultSet rs_memo;
    java.sql.ResultSet rs_collections;
    java.sql.ResultSet rs_replies;
    java.sql.Statement st;
    java.sql.Statement st1;
    java.sql.Statement st2;
    Class.forName("com.mysql.jdbc.Driver");
    conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost/thehub", "root", "1234");
    st = conn.createStatement();
    st1 = conn.createStatement();
    st2 = conn.createStatement();

    //USE THIS GLOBALLY. Just make sure to use this same string name if you change it up
    String current_user_id = "1";   //get this later once login.jsp has been made.
  %>

<%--  enter in a new memo here --%>
  <textarea maxlength="239" rows="4" cols="50" name="memo_text" form="memoform"></textarea>
  <form name="memo" action="memo.jsp" method="post" id="memoform">
      <select name="collection_data">
      <option value="not_added_to_collection">Post without adding to a collection</option>
      <%
        //creating the drop down menu with all the collections
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
<%--  table of all the memos--%>
  <div id="memo_tables">
    <table class="fixed" style="border: solid black 1px" cellpadding="5">
      <tbody>
      <col width="200px">
      <col width="100px">
        <tr>
          <td><%=rs_memo.getString("date_created")%></td>
          <td border="0" cellpadding="0">  <!-- Delete memo entry button form-->
            <form name="delete_memo" action="delete_memo.jsp">
              <input type="submit" name="delete_memo" value="Delete">
              <input type="hidden" name="memo_id" value="<%=rs_memo.getString("memo_id")%>">
            </form>
          </td>
        </tr>
        <tr>
          <td><%=rs_memo.getString("journal_cdata")%></td>
          <td>
            <%
              //from here to line 111 has to do with changing the current collection of the memo
              String current_collection_name = "Not in Collection";
              rs_collections.beforeFirst();
              while (rs_collections.next()){
                if (rs_collections.getInt("collection_id") == rs_memo.getInt("collection_id")){
                    current_collection_name = rs_collections.getString("collection_name");
                }
              }
            %>
            Collection:
            <br>
<%--            form to change the collection. submits the form when user changes the select value. kinda neat. --%>
            <form name="change_collection" action="change_collection.jsp">
              <select name="change_collection" onchange="this.form.submit()">
                <option><%=current_collection_name%></option>
                <%
                  rs_collections.beforeFirst();
                  while (rs_collections.next()){
                    if (!rs_collections.getString("collection_name").equals(current_collection_name)){
                %>
                    <option value="<%=rs_collections.getInt("collection_id")%>">
                      <%=rs_collections.getString("collection_name")%></option>
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
        String qr_replies = "SELECT * FROM replies WHERE memo_id = '"+rs_memo.getString("memo_id")+"';";
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
            <input type="hidden" name="user_id" value="<%=current_user_id%>">
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
    String qr_collections2 = "SELECT * FROM collections WHERE user_id = '"+current_user_id+"';";
    rs_collections = st.executeQuery(qr_collections2);
%><div id="collection_table"><%
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
        String qr_memo2 = "SELECT * FROM memos WHERE collection_id = '"+rs_collections.getString("collection_id")+"'";
        rs_memo = st1.executeQuery(qr_memo2);
        while (rs_memo.next()){
      %><tr><div id="td2"><td><%=rs_memo.getString("journal_cdata")%></td></div></tr>
      <br><%}
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
  </body>

<%--this popup is the adding of a new collection --%>
  <div class="form-popup" id="add_collection_form">
    <form action="add_collection.jsp" class="form-container">
      <h1 style="font-size: 20px">Create a new collection</h1>
      <input type="text" placeholder="Enter Collection Name" name="new_collection_name" required>
      <input type="hidden" name="user_id" value="<%=current_user_id%>">
      <button type="submit" class="btn">Create</button>
      <button type="submit" class="btn cancel" onclick="closeForm()">Cancel</button>
    </form>
  </div>

  <style>
    table.fixed { table-layout:fixed; }
    table.fixed #td2 { overflow: hidden; }

    #collection_table {
      /*align: right;*/
      position: absolute;
      top:100px;
      right:50px;
    }
    #memo_tables {
      position: relative;
      top: 0;
      left: 0;
    }
    {box-sizing: border-box;}

    /* Button used to open the contact form - fixed at the bottom of the page */
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

    /* Set a style for the submit/login button */
    .form-container .btn {
      background-color: #4CAF50;
      color: white;
      padding: 16px 20px;
      border: none;
      cursor: pointer;
      width: 100%;
      margin-bottom:10px;
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



    body {font-family: Helvetica, sans-serif;}
  </style>

</html>
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