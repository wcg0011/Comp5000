<%-- 
    Document   : loginAndSignup.jsp
    Created on : 04/17/2019
    Author     : Aidan Lambrecht, taken from Abishek's examples
--%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style>
            * {
                background-color: white;
                margin: auto;
                list-style: none;
            }

            header, section, article {
                display: block;
                margin: auto;
            }

            table, body {
                margin: auto;
                margin-top: 8px;
                margin-bottom: 8px;
            }

            h1 {
                margin: auto;
                width: 50%;
                padding-top: 15px;
            }

            h2 {
                margin: auto;
                width: 50%;
                padding-top: 15px;
                padding-left: 10px;
            }

            h3 {
                padding-top: 15px;
                padding-right: 15px;
                padding-left: 15px;
                padding-bottom: 3px;
                margin: auto;
                width: 50%;
                display: inline;
            }

            th {
                background-color: white;
                color: White;
                font-family: "Georgia", serif;
            }

            td {
                background-color: white;
                color: Black;
                font-family: "serif";
            }

            th, td {
                padding: 15px;

            }
        </style>
        <title>The Hub: Login/Sign up</title>
        <script type="text/javascript">
        function validate() {
            // javascript code to validate user input 
            var str=true;
            document.getElementById("msg").innerHTML="";                    
            
            pwd = document.signupform.password.value;
            cpwd = document.signupform.confirm.value;
            
            
            if(pwd == cpwd) {
                
            }
            else {
                document.getElementById("msg").innerHTML="Password and confirm password must match.!";
                str=false;
            }
            
            if(document.signupform.password.value == '')
            {
                document.getElementById("msg").innerHTML="Enter Password";
                str=false;
            }
            
            if(document.signupform.username.value == '')
            {
                document.getElementById("msg").innerHTML="Enter Username";
                str=false;
            }
            
            lastname = document.signupform.lastname.value;
            if(isNaN(lastname))
            {
            }
            else
            {
                document.getElementById("msg").innerHTML="Numbers are not allowed for last name.!";
                str=false;
            }
            
            if(document.signupform.lastname.value == '')
            {
                document.getElementById("msg").innerHTML="Enter Lastname";
                str=false;
            }
            
            firstname = document.signupform.firstname.value;
            if(isNaN(firstname))
            {
            }
            else
            {
                document.getElementById("msg").innerHTML="Numbers are not allowed for first name.!";
                str=false;
            }
        
            if(document.signupform.firstname.value == '')
            {
                document.getElementById("msg").innerHTML="Enter Firstname";
                str=false;
            }
            
            
            
        return str;       
        }
        </script>
    </head>
    <body>
    <h1>The Hub</h1>
            <h2>Login/Sign Up</h2>
        <div>
            <form name="loginform" method="POST" action="loginprocess.jsp">            <!-- On submit, the page will be redirected to loginprocess.jsp -->
                <table border="0" cellpadding="5" align="center" width = "800px">
                    <tr>
                        <td colspan="2"><h3>Login</h3></td>
                    </tr>
                    <tr>
                        <td>Username:</td>
                        <td><input type="text" name="username" required /></td>                  <!-- name: username -->
                    </tr>
                    <tr>
                        <td>Password:</td>
                        <td><input type="password" name="password" required/></td>               <!-- name: password -->
                    </tr>
                    <tr>
                        <td><input type="submit" value="Login" /> </td>
                        <td>
                            <%
                                if(request.getParameter("c")!= null) {
                                    //check the value for variable "c"
                                    out.println("Username or password is incorrect.");
                                }
                            %>
                        </td>
                    </tr>
                </table>
            </form>
            
            
            <form name="signupform" method="POST" action="signupprocess.jsp" onSubmit="return validate()">           <!-- On submit, the page will be redirected to signupprocess.jsp -->
                <table border="0" cellpadding="5" align="center" width = "800px">
                    <tr>
                        <td colspan="2"><h3>Register</h3></td>
                    </tr>
                    
                    <tr>
                        <td>First Name:</td>
                        <td><input type="text" name="firstname"  /></td>                 <!-- name: firstname -->
                    </tr>
                    
                    <tr>
                        <td>Last Name:</td>
                        <td><input type="text" name="lastname" /></td>                   <!-- name: lastname -->
                    </tr>
                    <tr>
                        <td>Username:</td>
                        <td><input type="text" name="username" /></td>                  <!-- name: username -->
                    </tr>
                    <tr>
                        <td>Password:</td>
                        <td><input type="password" name="password" /></td>              <!-- name: password -->
                    </tr>
                    <tr>
                        <td>Confirm Password:</td>
                        <td><input type="password" name="confirm" /></td>               <!-- name: confirm -->
                    </tr>
                    <tr>
                        <td><input type="submit" name="signup" value="Sign up" /></td>
                        <td>
                            <span id="msg"> </span>                                     <!-- span tag to print validation errors -->
                            <%
                                if(request.getParameter("a")!= null) {
                                    //check the value for variable "a"
                                    out.println("Username already exists. Please choose another username.");
                                }
                                
                                if(request.getParameter("b")!= null) {
                                    //check the value for variable "b"
                                    //out.println("Please login or sign up");
                                    %> <br/> <h3>Please login or sign up</h3> <%
                                }
                            %>
                        </td>                      

                    </tr>
                </table>
            </form>
           
        </div>          
    </body>
</html>