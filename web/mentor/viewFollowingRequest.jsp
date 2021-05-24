<%-- 
    Document   : viewFollowingRequest
    Created on : May 22, 2021, 10:48:52 AM
    Author     : Tran Phong <phongntse150974@fpt.edu.vn>
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Following Requests</title>
    </head>
    <body>
        <h1>Requests from the Mentees following you</h1>
        <c:set var="requestsList" value="${requestScope.FOLLOWING_REQUESTS}" />
        <c:if test="${not empty requestsList}">
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
                
                <c:forEach items="${requestsList}" var="request" varStatus="count">
                    <c:set var="listSkillsID" value="${request.skillsID}" />
                    <c:set var="listSkills" value="${skillsDAO.getSkillsList(listSkillsID)}" />
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
                        ${request.reqContent}
                    </td>
                    <td>
                        <c:forEach items="${listSkills}" var="skill">
                            ${skill.skillName}, 
                         </c:forEach>
                    </td>
                    <td>
                        <input type="submit" value="Accept" name="btnAction" />
                        <input type="submit" value="Reject" name="btnAction" />
                    </td>
                </tr> 
                </c:forEach>
            </tbody>
        </table>
                </c:if>

    </body>
</html>
