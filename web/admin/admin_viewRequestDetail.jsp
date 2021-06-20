<%-- 
    Document   : admin_viewRequestDetail
    Created on : Jun 9, 2021, 8:59:07 PM
    Author     : Tran Phong <phongntse150974@fpt.edu.vn>
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Request Detail</title>
    </head>
    <body>
        <c:set var="user" value="${sessionScope.CURRENT_USER.userID}" scope="page"/>
        <c:if test="${empty user}">
            <c:redirect url="LoginPage" />
        </c:if>
        <c:if test="${not fn:startsWith(user.userID, 'AD')}">
            <c:redirect url="/" />
        </c:if>
        <h1>View Detail of a Request</h1>
        <c:set var="error" value="${VIEW_REQUEST_ERROR}"/>
        <c:if test="${not empty error}">
            <font color="red">
            ${error}
            </font>
        </c:if>
        <c:set var="data" value="${REQUEST_INFO}"/>
        <c:set var="skillsName" value="${SKILLS_NAME}"/>
        <c:if test="${not empty data and not empty skillsName}">
            <h3>Details for request ${data.requestID}</h3>
            <ul>
                <li>Title: ${data.title}</li>
                <li>Deadline date: ${(fn:split(data.deadline," "))[0]}</li>
                <li>Deadline hour: ${(fn:split(data.deadline,' '))[1]}</li>
                <li>Request content: ${data.reqContent}</li>
                <li>Skills: ${skillsName}</li>
                <li>Status: <c:choose>
                        <c:when test="${data.status eq 'P'}">Pending</c:when>
                        <c:when test="${data.status eq 'A'}">Accepted</c:when>
                        <c:when test="${data.status eq 'R'}">Rejected</c:when>
                        <c:when test="${data.status eq 'C'}">Closed</c:when>
                </c:choose></li>
            </ul>

        </c:if>
    </body>
</html>
