<%-- 
    Document   : admin_viewMenteeStatistics
    Created on : Jun 7, 2021, 9:36:36 AM
    Author     : Tran Phong <phongntse150974@fpt.edu.vn>
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Mentee Statistics</title>
    </head>
    <body>
        <c:set var="user" value="${sessionScope.CURRENT_USER.userID}" scope="page"/>
        <c:if test="${empty user}">
            <c:redirect url="LoginPage" />
        </c:if>
        <c:if test="${not fn:startsWith(user.userID, 'AD')}">
            <c:redirect url="/" />
        </c:if>
        <h1>View Statistics about all the Mentees</h1>
        <c:set var="error" value="${MENTEE_STATISTICS_ERROR}" />
        <c:if test="${not empty error}">
            <font color="red">
            ${error}
            </font>
        </c:if>
        <c:set var="data" value="${MENTEE_STATISTICS_DATA}" />
        <c:if test="${not empty data}">
            <table border="1">
                <thead>
                    <tr>
                        <th>No.</th>
                        <th>Mentee's Full name</th>
                        <th>Mentee's Username</th>
                        <th>Total number of Mentors</th>
                        <th>Total hours of Requests</th>
                        <th>Total skills of all Requests</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${data}" var="statistics" varStatus="count">
                    <tr>
                        <td>
                            ${count.count}
                        </td>
                        <td>
                            ${statistics.menteeName}
                        </td>
                        <td>
                            ${statistics.username}
                        </td>
                        <td>
                            ${statistics.numMentor}
                        </td>
                        <td>
                            ${statistics.requestTotalHour}
                        </td>
                        <td>
                            ${statistics.totalSkills}
                        </td>
                    </tr>
                    </c:forEach>
                </tbody>
            </table>

        </c:if>
    </body>
</html>
