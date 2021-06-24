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
        <c:if test="${empty sessionScope.CURRENT_USER}">
            <c:redirect url="/login.jsp"/>
        </c:if>
        <c:if test="${not empty sessionScope.CURRENT_USER}">
            <form action="Logout" method="POST" id="Logout">
                <p id="Welcome">
                    <input type="submit" value="Logout" class="btn"/>
                </p>
            </form>
            <c:set var="CURRENT_USER" value="${sessionScope.CURRENT_USER}"/>
            Welcome, ${CURRENT_USER.username}<br/>
            <a href="UpdateProfilePage">View Profile</a><br/>
            <a href="MenteeCreateRequestPage">Create request</a><br/>
            <a href="MenteeListRequest">List my requests</a><br/>
            <a href="MenteeStatisticRequest">Statistic of requests</a><br/>
            <a href="MenteeLoadRequest?action=Update">Update request</a><br/>
            <a href="MenteeRate">Rate & Comment mentor</a><br/>
            <a href="MenteeLoadRequest?action=Suggest">List mentor suggestion</a><br/>
            <a href="MenteeFollowMentor">Follow mentor</a><br/>
        </c:if>
    </body>
</html>
