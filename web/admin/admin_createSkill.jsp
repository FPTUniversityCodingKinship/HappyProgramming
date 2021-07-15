<%-- 
    Document   : admin_createSkill
    Created on : Jun 2, 2021, 7:53:14 PM
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
        <title>Create skill</title>
    </head>
    <body>
        <c:if test="${fn:contains(sessionScope.CURRENT_USER.userID, 'ME')}">
            <h1 class="text-danger">
                Unauthorised access detected! Redirecting...
            </h1>

            <script>
                setTimeout(function () {
                    document.location = "MenteeCreateRequestPage";
                }, 2000);
            </script>
        </c:if>
        <c:if test="${fn:contains(sessionScope.CURRENT_USER.userID, 'MT')}">
            <h1 class="text-danger">
                Unauthorised access detected! Redirecting...           
            </h1>
            <script>
                setTimeout(function () {
                    document.location = "FollowingRequest";
                }, 2000);
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
                        <jsp:param name="page" value="createSkill"/>
                    </jsp:include>
                </header>
                <main>
                    <div id="content">
                        <jsp:include flush="true" page="/topMenu.jsp"/>
                        <h1>Create Skill</h1>
                        <form action="AdminCreateSkill" method="POST">
                            Skill name: <input type="text" name="skillName" value="${param.skillName}" /><br/>
                            <c:if test="${not empty requestScope.SKILL_NAME_ERROR.skillNameExisted}">
                                <font color="red">${requestScope.SKILL_NAME_ERROR.skillNameExisted}</font><br/>
                            </c:if>
                            <c:if test="${not empty requestScope.SKILL_NAME_ERROR.skillNameLengthErr}">
                                <font color="red">${requestScope.SKILL_NAME_ERROR.skillNameLengthErr}</font><br/>
                            </c:if>
                            It is a: <input type="radio" name="skillType" value="PL" required="required"/>
                            <label for="PL">Programming Language</label>
                            <input type="radio" name="skillType" value="FW" />
                            <label for="PL">Framework</label><br/>
                            <input class='btn btn-primary' type="submit" value="OK" onclick="valRadio()"/>
                        </form>
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
