<%-- 
    Document   : mentee_statisticRequest
    Created on : May 26, 2021, 3:14:41 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Statistic of requests</title>
    </head>
    <body>
        <c:if test="${not empty sessionScope.CURRENT_USER}">
            <c:set var="user" value="${sessionScope.CURRENT_USER}"/>
            Mentee ID: ${user.userID}<br/>
        </c:if>
        <c:if test="${not empty requestScope.REQUESTS_TITLE}" >
            Title of requests: 
            <c:set var="titles" value="${requestScope.REQUESTS_TITLE}" />
            <c:forEach var="title" items="${titles}">
                ${title},
            </c:forEach> 
        </c:if>
        <c:if test="${empty requestScope.REQUESTS_TITLE}">
            Title of requests: (No request yet)
        </c:if><br/>
        <c:if test="${not empty requestScope.TOTAL_REQUEST}" >
            Total of request: ${requestScope.TOTAL_REQUEST}
        </c:if><br/>
        <c:if test="${not empty requestScope.TOTAL_HOUR}" >
            Total of hours of all request: ${requestScope.TOTAL_HOUR}
        </c:if><br/>
        <c:if test="${not empty requestScope.TOTAL_MENTOR}" >
            Total mentor: ${requestScope.TOTAL_MENTOR}
        </c:if><br/>
    </body>
</html>
