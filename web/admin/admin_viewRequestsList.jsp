<%-- 
    Document   : admin_viewRequestsList
    Created on : Jun 8, 2021, 8:11:56 PM
    Author     : Tran Phong <phongntse150974@fpt.edu.vn>
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Requests List</title>
    </head>
    <body>
        <h1>View List of Requests</h1>
        <c:set var="pending" value="false" />
        <c:set var="accepted" value="false" />
        <c:set var="rejected" value="false" />
        <c:set var="closed" value="false" />
        <c:forEach var="item" items="${paramValues.status}">
            <c:if test="${item eq 'P'}">
                <c:set var="pending" value="true" />
            </c:if>
            <c:if test="${item eq 'A'}">
                <c:set var="accepted" value="true" />
            </c:if>
            <c:if test="${item eq 'R'}">
                <c:set var="rejected" value="true" />
            </c:if>
            <c:if test="${item eq 'C'}">
                <c:set var="closed" value="true" />
            </c:if>
        </c:forEach>
        <form action="AdminViewRequestsList">
            Search: <input type="text" name="searchValue" 
                           value="${param.searchValue}" placeholder="Java, Algorithm..." />
            <br/><em>Enter value you want the request's content to contain, or leave blank to search all the requests</em>
            <br/>
            Request Status: 
            <input type="checkbox" name="status" value="P" id="pending" <c:if test="${pending eq 'true'}">checked=""</c:if> /> Pending 
            <input type="checkbox" name="status" value="A" id="accepted" <c:if test="${accepted eq 'true'}">checked=""</c:if> /> Accepted 
            <input type="checkbox" name="status" value="R" id="rejected" <c:if test="${rejected eq 'true'}">checked=""</c:if> /> Rejected 
            <input type="checkbox" name="status" value="C" id="closed" <c:if test="${closed eq 'true'}">checked=""</c:if> /> Closed
                <br/>
                Start Date: <input type="date" name="startDate" id="startDate" value="${param.startDate}" /> 
            End Date: <input type="date" name="endDate" id="endDate" value="${param.endDate}" />
            <br/>
            <em>Filter the requests that have opened date after "Start Date" and closed / rejected date before "End Date" </em></br>
            <input type="submit" value="Search" name="btnSearch" />
        </form>
        <br/>
        <c:set var="error" value="${VIEW_REQUESTS_LIST_ERROR}" />
        <c:if test="${not empty error}">
            <font color="red">
            ${error}
            </font>
        </c:if>

        <c:set var="data" value="${REQUESTS_LIST}" />
        <c:if test="${empty error and data.size() eq 0}">
            <font color="red">
            No matched request is found!!
            </font>
        </c:if>
        <c:if test="${not empty data}">
            <table border="1">
                <thead>
                    <tr>
                        <th>No.</th>
                        <th>Request ID</th>
                        <th>Mentee created request</th>
                        <th>Request Title</th>
                        <th>Request Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${data}" var="request" varStatus="count">
                        <tr>
                            <td>
                                ${count.count}
                            </td>
                            <td>
                                <c:url var="requestDetail" value="AdminViewRequestDetail">
                                    <c:param name="requestID" value="${request.requestID}"/>
                                </c:url>
                                <a href="${requestDetail}">${request.requestID}</a>
                                
                            </td>
                            <td>
                                ${request.menteeID}
                            </td>
                            <td>
                                ${request.title}
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${request.status eq 'A'}">
                                        Accepted
                                    </c:when>
                                    <c:when test="${request.status eq 'P'}">
                                        Pending
                                    </c:when>
                                    <c:when test="${request.status eq 'R'}">
                                        Rejected
                                    </c:when>
                                    <c:when test="${request.status eq 'C'}">
                                        Closed
                                    </c:when>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>

        <!-- The infor of the list of request include: 
        STT, 
        ID (Click to view Detail), 
        accountname (who create request), 
        title of request, 
        status.-->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="admin/js/admin_viewRequestsList.js"></script>
    </body>
</html>
