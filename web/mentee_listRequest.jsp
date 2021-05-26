<%-- 
    Document   : mentee_listRequest
    Created on : May 24, 2021, 2:40:53 PM
    Author     : ADMIN
--%>

<%@page import="hps.requests.RequestsDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List of requests</title>
    </head>
    <body>
        <c:if test="${not empty sessionScope.CURRENT_USER}">
            <c:set var="user" value="${sessionScope.CURRENT_USER}"/>

            Mentee ID: ${user.userID}<br/>
        </c:if>

        <c:if test="${not empty requestScope.MENTEE_LIST_REQUEST}">
            <c:set var="listRequest" value="${requestScope.MENTEE_LIST_REQUEST}"/>
            <table border="1">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Title</th>
                        <th>Deadline Date</th>
                        <th>Deadline Hour</th>
                        <th>Content</th>
                        <th>Skill(s)</th>
                        <th>Status</th>
                        <th>Delete</th>
                        <th>Update</th>
                    </tr>
                </thead>
                <tbody>
                    <jsp:useBean id="skillsDAO" class="hps.skills.SkillsDAO" />
                    <c:forEach var="dto" items="${listRequest}" varStatus="counter">
                        <form action="MenteeDeleteUpdateDispatcher" method="POST">
                            <c:set var="skillsID" value="${dto.skillsID}" />
                            <tr>
                                <td>
                                    <input id="requestID" type="hidden" name="requestID" value="${dto.requestID}" />
                                    ${counter.count}
                                </td>
                                <td>
                                    <input type="text" name="title" value="${dto.title}" />
                                </td>
                                <td>
                                    <input type="text" name="deadlineDate" value="${(fn:split(dto.deadline," "))[0]}" />
                                </td>
                                <td>
                                    <c:set var="hour" value="${(fn:split(dto.deadline,' '))[1]}" />
                                    <input type="text" name="deadlineHour" value="${fn:substring(hour,0,5)}" />
                                </td>
                                <td>
                                    <input type="text" name="reqContent" value="${dto.reqContent}" />
                                </td>
                                <td>
                                    <input type="text" name="skillsName" value="${skillsDAO.getSkillsName(skillsID)}" />
                                </td>
                                <td>
                                    ${dto.status}
                                </td>
                                <td>
                                    <input type="submit" value="Delete" name="btnAction" 
                                           onclick="return confirm('Are you sure that you want to DELETE this request?')"/>
                                </td>
                                <c:if test="${dto.status eq 'P'}">
                                <td>
                                    <input type="submit" value="Update" name="btnAction" 
                                           onclick="return confirm('Are you sure that you want to UPDATE this request?')"/>
                                </td>
                                </c:if> 
                            </tr>
                        </form>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
        <c:set var="error" value="${requestScope.UPDATE_REQUEST_ERROR}"/>
        <c:if test="${not empty error.titleLengthError}" >
                <font color="red">${error.titleLengthError}</font><br/>
        </c:if>
        <c:if test="${not empty error.deadlineDateError}" >
            <font color="red">${error.deadlineDateError}</font><br/>
        </c:if>
        <c:if test="${not empty error.deadlineTimeError}" >
            <font color="red">${error.deadlineTimeError}</font><br/>
        </c:if>
        <c:if test="${not empty error.contentLengthError}" >
            <font color="red">${error.contentLengthError}</font><br/>
        </c:if>
            
        <c:set var="skillErrors" value="${requestScope.UPDATE_SKILL_ERROR}" />
        <c:if test="${not empty skillErrors.skillNameNotFound}" >
            <font color="red">${skillErrors.skillNameNotFound}</font><br/>
        </c:if>
        <c:if test="${not empty skillErrors.skillQuantityError}" >
            <font color="red">${skillErrors.skillQuantityError}</font><br/>
        </c:if>
        
        <c:if test="${empty requestScope.MENTEE_LIST_REQUEST}">
            Your number of requests: 0
        </c:if>
    </body>
    </html>
