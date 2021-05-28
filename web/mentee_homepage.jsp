<%-- 
    Document   : mentee_homepage
    Created on : May 22, 2021, 8:32:24 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mentee Homepage</title>
    </head>
    <body>
        <c:if test="${not empty sessionScope.CURRENT_USER}">
            <c:set var="CURRENT_USER" value="${sessionScope.CURRENT_USER}"/>
            Welcome, ${CURRENT_USER.username}<br/>
            <a href="MenteeRequestPage">Create request</a><br/>
            <a href="MenteeListRequest">List my requests</a><br/>
            <a href="MenteeStatisticRequest">Statistic of requests</a><br/>
            <a href="MenteeLoadRequest">Update request</a>
        </c:if>
    </body>
</html>
