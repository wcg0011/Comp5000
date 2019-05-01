<%-- 
    Document   : abt
    Created on : Apr 28, 2019, 3:31:44 PM
    Author     : Cole
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>About</title>
    </head>
    <body>
        

        <h1>Overview</h1>
        <c:import var = "About" url="http://localhost:8080/About.xml"/>

        <x:parse xml = "${Team}" var="output"/>
        
        <b>Purpose:</b><br/>
        <x:out select= "$output/Team/Overview"/>
        
        <b>Meet the Team:</b><br/>
        
 <%--   This could work too, just comment out everything below

        <x:forEach select = "$output/Team/TeamMember" var ="Mem">
            <h1>Name:</h1><br/>
            <x:out select = "$output/Team/TeamMember/Name"/>
            <br/><b>Major: </b>
            <x:out select = "$output/Team/TeamMember/Major"/>
            <br/><b>Years of school left: </b>
            <x:out select = "$output/Team/TeamMember/YearsLeft"/>
            <br/><b>Project Responsibilities: </b>
            <x:out select = "$output/Team/TeamMember/Responsibilities"/>
        </x:forEach>
 --%>          
            
        <h1>Name:</h1><br/>
        <x:out select = "$output/Team/TeamMember[1]/Name"/>
        <br/><b>Major: </b>
        <x:out select = "$output/Team/TeamMember[1]/Major"/>
        <br/><b>Years of school left: </b>
        <x:out select = "$output/Team/TeamMember[1]/YearsLeft"/>
        <br/><b>Project Responsibilities: </b>
        <x:out select = "$output/Team/TeamMember[1]/Responsibilities"/>
            
            
        <h1>Name:</h1><br/>
        <x:out select = "$output/Team/TeamMember[2]/Name"/>
        <br/><b>Major: </b>
        <x:out select = "$output/Team/TeamMember[2]/Major"/>
        <br/><b>Years of school left: </b>
        <x:out select = "$output/Team/TeamMember[2]/YearsLeft"/>
        <br/><b>Project Responsibilities: </b>
        <x:out select = "$output/Team/TeamMember[2]/Responsibilities"/>
            
            
        <h1>Name:</h1><br/>
        <x:out select = "$output/Team/TeamMember[3]/Name"/>
        <br/><b>Major: </b>
        <x:out select = "$output/Team/TeamMember[3]/Major"/>
        <br/><b>Years of school left: </b>
        <x:out select = "$output/Team/TeamMember[3]/YearsLeft"/>
        <br/><b>Project Responsibilities: </b>
        <x:out select = "$output/Team/TeamMember[3]/Responsibilities"/>
    </body>
</html>

