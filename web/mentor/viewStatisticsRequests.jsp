<%-- 
    Document   : viewStatisticsRequests
    Created on : Jun 6, 2021, 4:13:03 PM
    Author     : Tran Phong <phongntse150974@fpt.edu.vn>
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Requests' Statistics</title>
        <link rel='stylesheet' href='mentor/css/viewStatisticsRequests.css'>
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
        <h1>View Statistics about all of the Requests that belong to you</h1>
        <c:set var="error" value="${STATISTICS_ERROR}" />
        <c:if test="${not empty error}">
            <font color="red">
            ${error}
            </font>
        </c:if>
        <c:if test="${empty error}">
            <c:set var="data" value="${REQUESTS_STATISTICS_DATA}" />
            <c:if test="${not empty data}">
                <!-- Trigger/Open The Modal -->
                <button id="btnView">View Statistics</button>

                <!-- The Modal -->
                <div id="statistics" class="modal">

                    <!-- Modal content -->
                    <div class="modal-content">
                        <span class="close">&times;</span>
                        <p><strong>Your rating:</strong> ${data.rate}</p>
                        <p><strong>Number of currently accepted request:</strong> ${data.numAccepted}</p>
                        <p><strong>Number of currently requests:</strong> ${data.numRequests}</p>
                        <p><strong>Number of currently rejected request:</strong> ${data.numRejected}</p>
                        <p><strong>Percentage of rejected request:</strong> ${data.percentRejected}%</p>
                        <p><strong>Percentage of completed request:</strong> ${data.percentClosed}%</p>
                    </div>

                </div>
            </c:if>
        </c:if>

        <script src='mentor/js/viewStatisticsRequests.js'></script>
    </body>
</html>
