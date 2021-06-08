<%-- 
    Document   : admin_homepage.jsp
    Created on : May 31, 2021, 3:38:31 PM
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
            <form action="Logout" method="POST" id="Logout">
                <p id="Welcome">
                    <input type="submit" value="Logout" class="btn"/>
                </p>
            </form>
        </c:if>
        <c:set var="mentor" value="${sessionScope.CURRENT_USER}"/>
            Welcome, ${mentor.fullname}<br/>
            
            <a href="AdminViewMentor">View list of all mentor</a><br/>
            <a href="AdminCreateSkillPage">Create skill</a><br/>
            <a href="AdminLoadSkills">Update skill</a><br/>
            <a href="AdminMenteeStatistics">View Mentee's Statistics</a><br/>
            <a href="AdminViewSkillsList">View List of all Skills</a><br/>
            
    </body>
</html>
