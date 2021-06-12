<%-- 
    Document   : viewInvitingRequest.jsp
    Created on : May 23, 2021, 8:24:14 PM
    Author     : Tran Phong <phongntse150974@fpt.edu.vn>
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Inviting Requests</title>
    </head>
    <body>
        <jsp:useBean id="userDao" class="hps.users.UsersDAO" scope="session"/>
        <c:set var="user" value="${userDao.getProfile(sessionScope.CURRENT_USER.userID)}"
               scope="page"/>
        <header>
            <nav>
                <form action="Login">
                    <input type="hidden" name="txtUsername" value="${user.username}" />
                    <input type="hidden" name="txtPassword" value="${user.password}" />
                    <input type="submit" value="Back" name="btAction"/>
                </form><br/>
            </nav>
        </header>
        <h1>Requests from the Mentees who invited you to be their Mentor</h1>
        <c:set var="error" value="${requestScope.FOLLOWING_ERROR}" />
        <c:if test="${not empty error}">
            <font color="red">
            ${error}
            </font>
        </c:if>
        <c:if test="${empty error}">
            <c:set var="requestsList" value="${requestScope.INVITING_REQUESTS}" />
             <c:if test="${empty requestsList}">
                There is no request that is from the mentees who invited you to be their Mentor...
            </c:if>
            <c:if test="${not empty requestsList}">
                <table border="1">
                    <thead>
                        <tr>
                            <th>No.</th>
                            <th>From Mentee</th>
                            <th>Title</th>
                            <th>Deadline date</th>
                            <th>Deadline hour</th>
                            <th>Content</th>
                            <th>Skills</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <jsp:useBean id="skillsDAO" class="hps.skills.SkillsDAO" />
                        <jsp:useBean id="usersDAO" class="hps.users.UsersDAO" />

                        <c:forEach items="${requestsList}" var="request" varStatus="count">
                            <c:set var="listSkillsID" value="${request.skillsID}" />
                            <c:set var="listSkills" value="${skillsDAO.getSkillsList(listSkillsID)}" />
                            <tr>
                                <td>
                                    ${count.count}
                                </td>
                                <td>
                                    <c:set var="menteeInfo" value="${usersDAO.getUserData(request.menteeID)}" />
                                    ${menteeInfo.fullname}
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
                                    <c:forEach items="${listSkills}" var="skill" varStatus="count">
                                        <c:if test="${count.count eq 1}">
                                            ${fn:trim(skill.skillName)}
                                        </c:if>
                                        <c:if test="${count.count ne 1}">
                                            , ${skill.skillName}
                                        </c:if>
                                    </c:forEach>
                                </td>
                                <c:if test="${request.status eq 'P'}">
                                    <td>
                                        <font color="purple">Pending</font>
                                    </td>
                                    <td>
                                        <c:url var="approveURL" value="Approve">
                                            <c:param name="requestID" value="${request.requestID}" />
                                            <c:param name="mentorID" value="${user.userID}" />
                                            <c:param name="redirect" value="InvitingRequest" />
                                        </c:url>
                                        <a href="${approveURL}">Approve</a>
                                        <c:url var="rejectURL" value="Reject">
                                            <c:param name="requestID" value="${request.requestID}" />
                                            <c:param name="mentorID" value="${user.userID}" />
                                            <c:param name="redirect" value="InvitingRequest" />
                                        </c:url>
                                        <a href="${rejectURL}">Reject</a>
                                    </td>
                                </c:if>
                                <c:if test="${request.status eq 'A'}">
                                    <td>
                                        <font color="purple">Approved - Processing</font>
                                    </td>
                                    <td>
                                        <c:url var="closeURL" value="Close">
                                            <c:param name="requestID" value="${request.requestID}" />
                                            <c:param name="redirect" value="InvitingRequest" />
                                        </c:url>
                                        <a href="${closeURL}">Close</a>
                                    </td>
                                </c:if>


                            </tr> 
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
            <font color="red">
            <c:if test="${not empty requestScope.REJECT_ERROR}">
                ${requestScope.REJECT_ERROR}
            </c:if>
            <c:if test="${not empty requestScope.APPROVE_ERROR}">
                ${requestScope.APPROVE_ERROR}
            </c:if>
            <c:if test="${not empty requestScope.CLOSE_ERROR}">
                ${requestScope.CLOSE_ERROR}
            </c:if>
            </font>
        </c:if>
    </body>
</html>
