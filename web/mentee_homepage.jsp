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
        <form action="Logout" method="POST" id="Logout">
        <p id="Welcome">
            Welcome, ${sessionScope.CURRENT_USER.getFullname()}.
            <input type="submit" value="Logout" class="btn"/>
        </p>
        </form>
        <c:if test="${not empty sessionScope.CURRENT_USER}">
            <c:set var="CURRENT_USER" value="${sessionScope.CURRENT_USER}"/>
            Welcome, ${CURRENT_USER.username}<br/>
            <a href="mentee_request.jsp">Create request</a>
        </c:if>
    </body>
</html>
