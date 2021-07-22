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
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="x-ua-compatible" content="ie=edge">

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.css">
        <title>View Mentee Statistics</title>
    </head>
    <body>
        <c:if test="${fn:contains(sessionScope.CURRENT_USER.userID, 'ME')}">
            <h1 class="text-danger">
                Unauthorised access detected! Redirecting in <span id='countdown'>2</span>...
            </h1>
            <script>
                var countdown = 2;
                setInterval(function () {
                    if (countdown <= 0) {
                        document.location = "MenteeCreateRequestPage";
                    }
                    document.getElementById('countdown').innerHTML = countdown;
                    countdown -= 1;
                }, 1000);
            </script>
        </c:if>
        <c:if test="${fn:contains(sessionScope.CURRENT_USER.userID, 'MT')}">
            <h1 class="text-danger">
                Unauthorised access detected! Redirecting in <span id='countdown'>2</span>...
            </h1>
            <script>
                var countdown = 2;
                setInterval(function () {
                    if (countdown <= 0) {
                        document.location = "FollowingRequest";
                    }
                    document.getElementById('countdown').innerHTML = countdown;
                    countdown -= 1;
                }, 1000);
            </script>
        </c:if>

        <c:if test="${fn:contains(sessionScope.CURRENT_USER.userID, 'AD')}">
            <div class="wrapper">
                <c:set var="user" value="${sessionScope.CURRENT_USER}" scope="page"/>
                <c:if test="${empty user}">
                    <c:redirect url="LoginPage" />
                </c:if>
                <c:if test="${not fn:startsWith(user.userID, 'AD')}">
                    <c:redirect url="/" />
                </c:if>
                <header>
                    <!--Menu-->
                    <jsp:include flush="true" page="adminMenu.jsp">
                        <jsp:param name="page" value="menteeStatistics"/>
                    </jsp:include>
                </header>
                <main>
                    <div id="content">
                        <jsp:include flush="true" page="/topMenu.jsp"/>
                        <h1>View Statistics about all the Mentees</h1>
                        <div class="row">
                            <div class="col-8">
                                <c:set var="error" value="${MENTEE_STATISTICS_ERROR}" />
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger mt-2" role="alert">
                                        ${error}
                                    </div>
                                </c:if>
                                <c:set var="data" value="${MENTEE_STATISTICS_DATA}" />
                                <c:if test="${not empty data}">
                                    <table class='table table-bordered table-hover mt-3'>
                                        <thead class='thead-light'>
                                            <tr>
                                                <th class="align-middle" scope='col'>No.</th>
                                                <th class="align-middle" scope='col'>Mentee's Full name</th>
                                                <th class="align-middle" scope='col'>Mentee's Username</th>
                                                <th class="align-middle" scope='col'>Total number of Mentors</th>
                                                <th class="align-middle" scope='col'>Total Request time</th>
                                                <th class="align-middle" scope='col'>Total Requested Skills</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${data}" var="statistics" varStatus="count">
                                                <tr>
                                                    <td class="align-middle" scope='row'>
                                                        ${count.count}
                                                    </td>
                                                    <td class="align-middle">
                                                        ${statistics.menteeName}
                                                    </td>
                                                    <td class="align-middle">
                                                        ${statistics.username}
                                                    </td>
                                                    <td class="align-middle">
                                                        ${statistics.numMentor}
                                                    </td>
                                                    <td class="align-middle">
                                                        ${statistics.requestTotalHour}
                                                    </td>
                                                    <td class="align-middle">
                                                        ${statistics.totalSkills}
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </c:if>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.concat.min.js"></script>
        <script src="js/menu.js"></script>
    </body>
</html>
