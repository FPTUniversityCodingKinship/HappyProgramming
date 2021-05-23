<%-- 
    Document   : viewInvitingRequest.jsp
    Created on : May 23, 2021, 8:24:14 PM
    Author     : Tran Phong <phongntse150974@fpt.edu.vn>
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Inviting Requests</title>
    </head>
    <body>
        <h1>Requests from the Mentees who chose you</h1>
        <c:set var="requestsList" value="${INVITING_REQUESTS}" />
        <table border="1">
            <thead>
                <tr>
                    <th>No.</th>
                    <th>Title</th>
                    <th>Deadline date</th>
                    <th>Deadline hour</th>
                    <th>Content</th>
                    <th>Skills</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <jsp:useBean id="skillsDAO" class="hps.skills.SkillsDAO" />
                <c:forEach items="requestsList" var="request" varStatus="count">
                    <c:set var="listSkills" value="${skillsDAO.getSkillsList(request.skillsID)}" />
                    <c:set var="listSkillsName" value="" />
                    <c:forEach items="listSkills" var="skill">
                        <c:set var="listSkillsName" value="${listSkillsName + skill.skillName}" />
                    </c:forEach>
                <tr>
                    <td>
                        ${count.count}
                    </td>
                    <td>
                        ${request.title}
                    </td>
                    <td>
                        ${(fn:split(request.deadline, " " ))[0]}
                    </td>
                    <td>
                        ${(fn:split(request.deadline, " " ))[1]}
                    </td>
                    <td>
                        ${request.content}
                    </td>
                    <td>
                        
                    </td>
                    <td></td>
                </tr>
                </c:forEach>
            </tbody>
        </table>

    </body>
</html>