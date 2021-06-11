<%-- 
    Document   : mentor_homepage
    Created on : Jun 6, 2021, 3:49:00 PM
    Author     : Tran Phong <phongntse150974@fpt.edu.vn>
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mentor Homepage</title>
    </head>
    <body>
        <c:if test="${empty sessionScope.CURRENT_USER}">
            <c:redirect url="/login.jsp"/>
        </c:if>
        <c:if test="${not empty sessionScope.CURRENT_USER}">
            <form action="Logout" method="POST" id="Logout">
                <p id="Welcome">
                    <input type="submit" value="Logout" class="btn"/>
                </p>
            </form>
            <c:set var="mentor" value="${sessionScope.CURRENT_USER}"/>
            Welcome, ${mentor.fullname}<br/>
            <a href="FollowingRequest">View Requests from your followers</a><br/>
            <a href="InvitingRequest">View Requests not from your followers</a><br/>
            <a href="CreateCVPage">Create your CV</a><br/>
            <a href="UpdateCVPage">Update your CV</a><br/>
            <a href="RequestsStatistics">View statistics about all requests of you</a><br/>
        </c:if>
    </body>
</html>
