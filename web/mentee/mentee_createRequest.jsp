<%-- 
    Document   : mentee_request
    Created on : May 22, 2021, 8:48:34 AM
    Author     : ADMIN
--%>

<%@page import="hps.skills.SkillsDTO"%>
<%@page import="java.util.ArrayList"%>
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
        <title>Create request</title>
    </head>
    <body>
        <c:if test="${fn:contains(sessionScope.CURRENT_USER.userID, 'MT')}">
            <h1 class="text-warning">
                Unauthorised access detected! Redirecting in <span id='countdown'>3</span>...
            </h1>
            <script>
                var countdown = 3;
                setInterval(function () {
                    if (countdown == 0) {
                        document.location.replace("FollowingRequest");
                        countdown -= 1;
                    } else if (countdown > 0) {
                        document.getElementById('countdown').innerHTML = countdown;
                        countdown -= 1;
                    }
                }, 1000);
            </script>
        </c:if>
        <c:if test="${fn:contains(sessionScope.CURRENT_USER.userID, 'AD')}">
            <h1 class="text-warning">
                Unauthorised access detected! Redirecting in <span id='countdown'>3</span>...
            </h1>
            <script>
                var countdown = 3;
                setInterval(function () {
                    if (countdown == 0) {
                        document.location = "AdminViewRequestsListPage";
                        countdown -= 1;
                    } else if (countdown > 0) {
                        document.getElementById('countdown').innerHTML = countdown;
                        countdown -= 1;
                    }
                }, 1000);
            </script>
        </c:if>
<c:if test="${sessionScope.CURRENT_USER.userID eq null}">
            <h1 class="text-warning">
                An unexpected error has happened! Redirecting in <span id='countdown'>3</span>...           
            </h1>
            <script>
                var countdown = 3;
                setInterval(function () {
                    if (countdown == 0) {
                        document.location = "/HappyProgramming/HomePage";
                        countdown -= 1;
                    } else if (countdown > 0) {
                        document.getElementById('countdown').innerHTML = countdown;
                        countdown -= 1;
                    }
                }, 1000);
            </script>
        </c:if>
        <c:if test="${fn:contains(sessionScope.CURRENT_USER.userID, 'ME')}">

            <div class="wrapper">
                <jsp:useBean id="userDao" class="hps.users.UsersDAO" scope="session"/>
                <c:set var="user" value="${userDao.getProfile(sessionScope.CURRENT_USER.userID)}"
                       scope="page"/>
                <!--            <header>
                                <nav>
                                    <form action="Login">
                                        <input type="hidden" name="txtUsername" value="${user.username}" />
                                        <input type="hidden" name="txtPassword" value="${user.password}" />
                                        <input type="submit" value="Back" name="btAction"/>
                                    </form><br/>
                                </nav>
                            </header>-->
                <header>
                    <!--Menu-->
                    <jsp:include flush="true" page="menteeMenu.jsp">
                        <jsp:param name="page" value="createRequest"/>
                    </jsp:include>
                </header>
                <main>
                    <div id="content">
                        <jsp:include flush="true" page="/topMenu.jsp"/>
                        <h1>Create Request</h1>
                        <c:set var="error" value="${requestScope.REQUEST_ERROR}"/>
                        <c:set var="success" value="${requestScope.SUCCESS_MESSAGE}"/>
                        <c:if test="${not empty success}">
                            <h3>
                                <span class="badge badge-success">
                                    <c:out value="${success}"/>
                                </span>
                            </h3>
                        </c:if>
                        <form action="MenteeCreateRequest" method="POST">
                            <div class="form-group row">
                                <div class="col-3">
                                    <label for="title" class="font-weight-bold">Title</label>
                                </div>
                                <div class="col-4">
                                    <input class="form-control" type="text" name="title" value="${param.title}"><br/>
                                    <c:if test="${not empty error.titleLengthError}" >
                                        <font color="red">${error.titleLengthError}</font><br/>
                                    </c:if>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-3">
                                    <label for="deadlineDate" class="font-weight-bold">Deadline date (year-month-day)</label>
                                </div>
                                <div class="col-4">
                                    <input class="form-control" type="text" name="deadlineDate" value="${param.deadlineDate}" /><br/>
                                    <c:if test="${not empty error.deadlineDateError}" >
                                        <font color="red">${error.deadlineDateError}</font><br/>
                                    </c:if>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-3">
                                    <label for="deadlineHour" class="font-weight-bold">Deadline hour (hour:minute)</label>
                                </div>
                                <div class="col-4">
                                    <input class="form-control" type="text" name="deadlineHour" value="${param.deadlineHour}" /><br/>
                                    <c:if test="${not empty error.deadlineTimeError}" >
                                        <font color="red">${error.deadlineTimeError}</font><br/>
                                    </c:if>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-3">
                                    <label for="reqContent" class="font-weight-bold">Content</label>
                                </div>
                                <div class="col-4">
                                    <textarea class="form-control" name="reqContent" rows="4" cols="30"></textarea><br/>
                                    <c:if test="${not empty error.contentLengthError}" >
                                        <font color="red">${error.contentLengthError}</font><br/>
                                    </c:if>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-3" class="font-weight-bold">
                                    <label class="font-weight-bold">Select skill (1-3) </label> 
                                </div>
                                <div class="col-4">
                                    <c:if test="${not empty sessionScope.SKILL_LIST}">
                                        <c:set var="skillList" value="${sessionScope.SKILL_LIST}"/>
                                        <c:forEach var="skill" items="${skillList}">
                                            <input class="form-check-input" type="checkbox" name="ckb" value="${skill.skillName}" 
                                                   onclick="return chkControl()"/>${skill.skillName}<br/>
                                        </c:forEach>
                                    </c:if>
                                    <c:if test="${not empty error.ckbError}" >
                                        <font color="red">${error.ckbError}</font><br/>
                                    </c:if>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-3">
                                    <label for="mentorID" class="font-weight-bold">Your mentor ID</label>
                                </div>
                                <div class="col-4">
                                    <input class="form-control" type="text" name="mentorID" value="${param.mentorID}" /><br/>
                                    <c:if test="${not empty error.mentorIDConflictError}" >
                                        <font color="red">${error.mentorIDConflictError}</font><br/>
                                    </c:if>
                                </div>
                            </div>
                            <input class="btn btn-primary" type="submit" value="OK" name="btnAction" onclick="valCkb()"/>
                        </form>
                    </div>
                </main>
            </div>
        </c:if>
            
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
        <script src="https://cdn.tiny.cloud/1/uvrwnlarfgzt2bb56y6vdl6cb5mhfr6h5sl6tqnucb5yuvvu/tinymce/5/tinymce.min.js" referrerpolicy="origin"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.concat.min.js"></script>
        <script src="js/menu.js"></script>
        <script>
            function chkControl() {
                var a = document.getElementsByName("ckb");
                var total = 0;
                var count;
                for (count = 0; count < a.length; count++) {
                    if (a[count].checked == true) {
                        total = total + 1;
                    }
                }
                if (total > 3 || total < 1) {
                    alert("Select at least 1, at most 3");
                    return false;
                }
            }
            function valCkb()
            {
                var checkboxs = document.getElementsByName("ckb");
                var iCheck = false;
                for (var i = 0; i < checkboxs.length; i++)
                {
                    if (checkboxs[i].checked)
                    {
                        iCheck = true;
                        break;
                    }
                }
                if (iCheck) {

                } else
                    alert("Please select at least 1 skill");
            }
        </script>
    </body>
</html>
