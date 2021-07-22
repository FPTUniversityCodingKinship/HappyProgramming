<%-- 
    Document   : admin_updateSkill
    Created on : Jun 3, 2021, 8:05:52 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.css">
        <title>Update skill</title>
    </head>
    <body>
        <c:if test="${fn:contains(sessionScope.CURRENT_USER.userID, 'ME')}">
            <h1 class="text-danger">
                Unauthorised access detected! Redirecting in <span id='countdown'>3</span>...
            </h1>
            <script>
                var countdown = 3;
                setInterval(function () {
                    if (countdown == 0) {
                        document.location = "MenteeCreateRequestPage";
                        countdown -= 1;
                    } else if (countdown > 0) {
                        document.getElementById('countdown').innerHTML = countdown;
                        countdown -= 1;
                    }
                }, 1000);
            </script>
        </c:if>
        <c:if test="${fn:contains(sessionScope.CURRENT_USER.userID, 'MT')}">
            <h1 class="text-danger">
                Unauthorised access detected! Redirecting in <span id='countdown'>3</span>...
            </h1>
            <script>
                var countdown = 3;
                setInterval(function () {
                    if (countdown == 0) {
                        document.location = "MentorHomePage";
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
        <c:if test="${fn:contains(sessionScope.CURRENT_USER.userID, 'AD')}">
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

            <div class="wrapper">
                <header>
                    <!--Menu-->
                    <jsp:include flush="true" page="adminMenu.jsp">
                        <jsp:param name="page" value="updateSkill"/>
                    </jsp:include>
                </header>
                <main>
                    <div id="content">
                        <jsp:include flush="true" page="/topMenu.jsp"/>
                        <h1>Update Skill</h1>
                        <c:if test="${not empty sessionScope.LIST_ALL_SKILLS}">
                            <c:set var="listSkills" value="${sessionScope.LIST_ALL_SKILLS}"/>
                            <form id="form1" action="AdminShowSkillInfo" method="POST">
                                <select name="skillName" onchange="document.getElementById('form1').submit();">
                                    <option>Choose skill</option>
                                    <c:forEach var="skill" items="${listSkills}">
                                        <option value="${skill.skillName}">${skill.skillName}</option>
                                    </c:forEach>
                                </select>
                            </form>
                            <br/>
                            <c:if test="${not empty sessionScope.SKILL_INFO}">
                                <form action="AdminUpdateSkill" method="POST">
                                    <c:set var="skillInfo" value="${sessionScope.SKILL_INFO}"/>
                                    <input type="hidden" name="skillID" value="${skillInfo.skillID}"/>
                                    <input type="hidden" name="currentSkillName" value="${skillInfo.skillName}"/>

                                    <div class="form-group row">
                                        <div class="col-2">
                                            <label for="txtSkillName" class="font-weight-bold">Skill name</label>
                                        </div>
                                        <div class="col-4">
                                            <input type="text" name="txtSkillName" value="${skillInfo.skillName}" /> <br/>
                                            <c:if test="${not empty requestScope.UPDATE_SKILL_ERROR.skillNameExisted}">
                                                <font color="red">${requestScope.UPDATE_SKILL_ERROR.skillNameExisted}</font><br/>
                                            </c:if>
                                            <c:if test="${not empty requestScope.UPDATE_SKILL_ERROR.skillNameLengthErr}">
                                                <font color="red">${requestScope.UPDATE_SKILL_ERROR.skillNameLengthErr}</font><br/>
                                            </c:if>
                                        </div>
                                    </div>
                                    <label class="font-weight-bold">Current status </label> <c:if test="${skillInfo.status eq 'true'}">Active</c:if>
                                    <c:if test="${skillInfo.status eq 'false'}">Inactive</c:if>
                                        <br/>
                                        <div class="form-group row">
                                            <div class="col-2">
                                                <label class="font-weight-bold">Status</label>
                                            </div>
                                            <div class="col-4">
                                                <select name="status">
                                                    <option>Active</option>
                                                    <option>Inactive</option>
                                                </select> <br/>
                                            </div>
                                        </div>
                                        <input class='btn btn-primary' type="submit" value="OK" />
                                    </form>
                            </c:if>
                        </c:if>
                    </div>
                </c:if>

                <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.concat.min.js"></script>
                <script src="js/menu.js"></script>
                </body>
                </html>
