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
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.css">
        <link rel="stylesheet" href="css/style.css">
        <title>List of requests</title>
    </head>
    <body>
        <jsp:useBean id="userDao" class="hps.users.UsersDAO" scope="session"/>
        <c:set var="user" value="${userDao.getProfile(sessionScope.CURRENT_USER.userID)}"
               scope="page"/>
        <!--        <header>
                    <nav>
                        <form action="Login">
                            <input type="hidden" name="txtUsername" value="${user.username}" />
                            <input type="hidden" name="txtPassword" value="${user.password}" />
                            <input type="submit" value="Back" name="btAction"/>
                        </form><br/>
                    </nav>
                </header>-->
        <c:if test="${fn:contains(sessionScope.CURRENT_USER.userID, 'MT')}">
            <h1 class="text-warning">
                Unauthorised access detected! Redirecting...
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
            <h1 class="text-warning">
                Unauthorised access detected! Redirecting...           
            </h1>
            <script>
                var countdown = 2;
                setInterval(function () {
                    if (countdown <= 0) {
                        document.location = "AdminViewRequestsListPage";
                    }
                    document.getElementById('countdown').innerHTML = countdown;
                    countdown -= 1;
                }, 1000);
            </script>
        </c:if>
        <c:if test="${fn:contains(sessionScope.CURRENT_USER.userID, 'ME')}">
            <div class="wrapper">
                <header>
                    <!--Menu-->
                    <jsp:include flush="true" page="menteeMenu.jsp">
                        <jsp:param name="page" value="listRequest"/>
                    </jsp:include>
                </header>
                <main>
                    <div id="content">
                        <jsp:include flush="true" page="/topMenu.jsp"/>
                        <h1>List Requests</h1>
                        <c:if test="${not empty sessionScope.CURRENT_USER}">
                            <c:set var="user" value="${sessionScope.CURRENT_USER}"/>

                            Mentee's ID: ${user.userID}<br/>
                        </c:if>

                        <c:if test="${not empty requestScope.MENTEE_LIST_REQUEST}">
                            <c:set var="listRequest" value="${requestScope.MENTEE_LIST_REQUEST}"/>
                            <table class='table table-bordered table-hover'>
                                <thead class='thead-light'>
                                    <tr>
                                        <th>No.</th>
                                        <th>Title</th>
                                        <th>Deadline Date</th>
                                        <th>Deadline Time</th>
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
                                                <c:if test="${dto.status eq 'P'}">
                                                    <input class="btn btn-primary" type="submit" value="Delete" name="btnAction" 
                                                           onclick="return confirm('Are you sure that you want to DELETE this request?')"/>
                                                </c:if> 
                                            </td>
                                            <td>
                                                <c:if test="${dto.status eq 'P'}">
                                                    <input class="btn btn-primary" type="submit" value="Update" name="btnAction" 
                                                           onclick="return confirm('Are you sure that you want to UPDATE this request?')"/>
                                                </c:if> 
                                            </td>
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
                    </div>
                </main>
            </div>
        </c:if>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
        <script src="https://cdn.tiny.cloud/1/uvrwnlarfgzt2bb56y6vdl6cb5mhfr6h5sl6tqnucb5yuvvu/tinymce/5/tinymce.min.js" referrerpolicy="origin"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.concat.min.js"></script>
        <script src="js/menu.js"></script>
    </body>
</html>
