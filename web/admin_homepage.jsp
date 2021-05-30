<%-- 
    Document   : admin_homepage
    Created on : May 30, 2021, 6:16:15 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Homepage</title>
    </head>
    <body>
        <c:if test="${not empty sessionScope.CURRENT_USER}">
            Welcome, ${sessionScope.CURRENT_USER.fullname}<br/>
        </c:if>
        <a href="AdminViewAllMentor">View list of all mentor</a><br/>
    </body>
</html>
