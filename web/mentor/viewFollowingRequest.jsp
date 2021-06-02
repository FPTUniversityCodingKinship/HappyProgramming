<%-- 
    Document   : viewFollowingRequest
    Created on : May 22, 2021, 10:48:52 AM
    Author     : Tran Phong <phongntse150974@fpt.edu.vn>
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                                        ${skill.skillName}
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
                                        <c:param name="redirect" value="FollowingRequest" />
                                    </c:url>
                                    <a href="${approveURL}">Approve</a>
                                    <c:url var="rejectURL" value="Reject">
                                        <c:param name="requestID" value="${request.requestID}" />
                                        <c:param name="redirect" value="FollowingRequest" />
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
                                        <c:param name="redirect" value="FollowingRequest" />
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
            There has been an error during your Rejecting operation... Please try again 
            or contact the web owner for more details!
        </c:if>
        <c:if test="${not empty requestScope.APPROVE_ERROR}">
            There has been an error during your Approving operation... Please try again 
            or contact the web owner for more details!
        </c:if>
        <c:if test="${not empty requestScope.FOLLOWING_ERROR}">
            There has been an error... Please try again 
            or contact the web owner for more details!
        </c:if>
        </font>
    </body>
</html>
