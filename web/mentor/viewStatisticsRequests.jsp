<%-- 
    Document   : viewStatisticsRequests
    Created on : Jun 6, 2021, 4:13:03 PM
    Author     : Tran Phong <phongntse150974@fpt.edu.vn>
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="x-ua-compatible" content="ie=edge">

        <link rel="stylesheet" href="css/bootstrap/bootstrap.min.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.css">
        <title>View Requests' Statistics</title>

    </head>
    <body>
        <div class="wrapper">
            <jsp:useBean id="userDao" class="hps.users.UsersDAO" scope="session"/>
            <c:set var="user" value="${userDao.getProfile(sessionScope.CURRENT_USER.userID)}"
                   scope="page"/>
            <c:if test="${empty user}">
                <c:redirect url="LoginPage" />
            </c:if>
            <c:if test="${not fn:startsWith(user.userID, 'MT')}">
                <c:redirect url="/" />
            </c:if>
            <header>
                <!--Menu-->
                <jsp:include flush="true" page="mentorMenu.jsp">
                    <jsp:param name="page" value="requestStats"/>
                </jsp:include>
            </header>
            <main>
                <div id="content">
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
                            <button class="btn btn-outline-primary" id="btnView" 
                                    data-toggle="modal" data-target="#statistics">View Statistics</button>

                            <!-- The Modal -->
                            <div class="modal fade" id="statistics" tabindex="-1" role="dialog" aria-labelledby="statisticsLabel" aria-hidden="true">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="statisticsLabel">Requests Statistics</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <p><strong>Your rating:</strong> <c:if test="${data.rate lt '0'}">${0}</c:if><c:if test="${data.rate ge '0'}">${data.rate}</c:if></p>
                                            <p><strong>Number of currently accepted request:</strong> ${data.numAccepted}</p>
                                            <p><strong>Number of currently requests:</strong> ${data.numRequests}</p>
                                            <p><strong>Number of currently rejected request:</strong> ${data.numRejected}</p>
                                            <p><strong>Percentage of rejected request:</strong> ${data.percentRejected}%</p>
                                            <p><strong>Percentage of completed request:</strong> ${data.percentClosed}%</p>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:if>
                </div>
            </main>
        </div>
        <script src = "js/jquery/jquery-3.6.0.min.js"></script>
        <script src = "js/popper/popper.min.js"></script>
        <script src = "js/bootstrap/bootstrap.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.concat.min.js"></script>
        <script src="js/menu.js"></script>
    </body>
</html>