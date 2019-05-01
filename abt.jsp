<%-- 
    Document   : abt
    Created on : Apr 28, 2019, 3:31:44 PM
    Author     : Cole
--%>

<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>About</title>
    </head>
    <body>
        
<%--
        <h1>User Info</h1>
        <c:import var = "userInfo" url="http://localhost:8080/about.xml"/>
        
        <x:parse xml= "${userData}" var="output"/>
        <b>First name is: </b>
        <x:out select = "$output/user/Firstname"/>
        
        <b>Last name is: </b>
        <x:out select = "$output/user/Lastname"/>
        
        <b>Username is: </b>
        <x:out select = "$output/user/Username"/>

        <b>Password is: </b>
        <x:out select = "$output/user/Password"/>

        <b>To-do</b><br/>

        <b>Text data: </b>
        <x:out select = "$output/user/Text_data"/>

        <b>Date created: </b>
        <x:out select = "$output/user/Date_created"/>

        <b>Due date: </b>
        <x:out select = "$output/user/Due_date"/>

        <b>Is it completed(0=no)(1=yes): </b>
        <x:out select = "$output/user/Is_completed"/>

        <b>Is it shown(0=no)(1=yes): </b>
        <x:out select = "$output/user/Is_shown"/>

        <b>Memo: </b><br/>

        <b>Journal data: </b>
        <x:out select = "$output/user/Journal_cdata"/>

        <b>Date created: </b>
        <x:out select = "$output/user/Date_created"/>

        <b>Collection ID: </b>
        <x:out select = "$output/user/Collection_id"/>

        <b>Is it in collection(0=no)(1=yes): </b>
        <x:out select = "$output/user/Is_in_collection"/>

        <b>Is it shown(0=no)(1=yes): </b>
        <x:out select = "$output/user/Is_shown"/>
--%>

        <x:forEach select = "$output/user" var ="user">
            <h1>User Info</h1><br/>
            <br/><b>First name is: </b>
            <x:out select = "$output/user/Firstname"/>
            <br/><b>Last name is: </b>
            <x:out select = "$output/user/Lastname"/>
            <br/><b>Username is: </b>
            <x:out select = "$output/user/Username"/>
            <br/><b>Password is: </b>
            <x:out select = "$output/user/Password"/>
            
            <b>To-do</b><br/>
            <x:forEach select = "$output/user/TodoList/Todo" var ="Todo">
                <br/><b>Text data: </b>
                <x:out select = "$output/user/Text_data"/>
                <br/><b>Date created: </b>
                <x:out select = "$output/user/Date_created"/>
                <br/><b>Due date: </b>
                <x:out select = "$output/user/Due_date"/>
                <br/><b>Is it completed(0=no)(1=yes): </b>
                <x:out select = "$output/user/Is_completed"/>
                <br/><b>Is it shown(0=no)(1=yes): </b>
                <x:out select = "$output/user/Is_shown"/>
            </x:forEach>
                
            <b>Memo: </b><br/>
            <x:forEach select = "$output/user/MeomList/Memo" var ="Memo">
                <br/><b>Journal data: </b>
                <x:out select = "$output/user/Journal_cdata"/>
                <br/><b>Date created: </b>
                <x:out select = "$output/user/Date_created"/>
                <br/><b>Collection ID: </b>
                <x:out select = "$output/user/Collection_id"/>
                <br/><b>Is it in collection(0=no)(1=yes): </b>
                <x:out select = "$output/user/Is_in_collection"/>
                <br/><b>Is it shown(0=no)(1=yes): </b>
                <x:out select = "$output/user/Is_shown"/>
            </x:forEach>
        </x:forEach>
    </body>
</html>

