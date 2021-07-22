<%-- 
    Document   : mentee_listSuggestion
    Created on : May 30, 2021, 7:33:53 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" integrity="sha512-iBBXm8fW90+nuLcSKlbmrPcLa0OT92xO1BIsZ+ywDWZCvqsWgccV3gFoRBv0z+8dLJgyAHIhR35VZc2oM/gI1w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="css/style.css">
        <title>List of suggested Mentor</title>
        <style>

        </style>
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
                <header>
                    <!--Menu-->
                    <jsp:include flush="true" page="menteeMenu.jsp">
                        <jsp:param name="page" value="listSuggestion"/>
                    </jsp:include>
                </header>
                <main>
                    <div id="content">
                        <jsp:include flush="true" page="/topMenu.jsp"/>
                        <h1>List Mentor Suggestion</h1>
                        <c:if test="${not empty sessionScope.LIST_REQUEST}">
                            <label class="font-weight-bold">
                                Please choose a request to get the list of suggested Mentor 
                            </label><br/>
                            <c:forEach var="request" items="${sessionScope.LIST_REQUEST}">
                                <c:url var="url" value="MenteeShowRequest">
                                    <c:param name="action" value="Suggest"/>
                                    <c:param name="requestID" value="${request.requestID}"/>
                                </c:url>
                                <i class="fas fa-chevron-right"></i> &nbsp;
                                <a href="${url}">${request.title}</a><br/>
                            </c:forEach>
                            <br/><br/>
                            <c:if test="${not empty sessionScope.REQUEST_INFO}">
                                <c:set var="request" value="${sessionScope.REQUEST_INFO}"/>
                                <c:set var="skillsName" value="${sessionScope.SKILLS_NAME}"/>
                                <span class="font-weight-bold">Skill(s): </span> 
                                <span class="text-danger"> ${skillsName} </span>
                                is/are selected for <span class="text-info">${request.title}</span> <br/>
                                <c:if test="${not empty sessionScope.MAPPING_MENTORS_ID}">
                                    <c:set var="listMentorsID" value="${sessionScope.MAPPING_MENTORS_ID}"/>
                                    <label class="font-weight-bold">Suggested mentor having these skills:</label>

                                    <c:forEach var="mentorID" items="${listMentorsID}">
                                        <c:url var="url" value="ShowMentorDetails">
                                            <c:param name="mentorID" value="${mentorID}"/>
                                        </c:url>
                                        <a href="${url}">${mentorID}</a>, 
                                    </c:forEach><br/><br/>
                                    <c:if test="${not empty sessionScope.MENTOR_INFO}">
                                        <c:set var="mentorInfo" value="${sessionScope.MENTOR_INFO}"/>
                                        <div class="form-group row">
                                            <div class="col-3">
                                                <label class="font-weight-bold">Mentor's fullname</label>
                                            </div>
                                            <div class="col-4">
                                                ${fn:split(mentorInfo, ",")[0]}<br/>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-3">
                                                <label class="font-weight-bold">Account's name</label>
                                            </div>
                                            <div class="col-4">
                                                ${fn:split(mentorInfo, ",")[1]}<br/>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-3">
                                                <label class="font-weight-bold">Rating (stars)</label>
                                            </div>
                                            <div class="col-4">
                                                ${fn:split(mentorInfo, ",")[2]}<br/>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-3">
                                                <label class="font-weight-bold">Number currently requests:</label>
                                            </div>
                                            <div class="col-4">
                                                ${fn:split(mentorInfo, ",")[3]}<br/>
                                            </div>
                                        </div>
                                    </c:if>
                                    <form action="MenteeListSuggestion" method="POST">    
                                        <c:if test="${not empty sessionScope.CHOSEN_MENTOR_ID}">
                                            <input type="hidden" name="chosenRequestID" value="${sessionScope.REQUEST_INFO.requestID}" />
                                            <input type="hidden" name="chosenMentorID" value="${sessionScope.CHOSEN_MENTOR_ID}" />
                                            <input class="btn btn-primary" type="submit" value="Invite" />
                                        </c:if>
                                    </form>
                                </c:if>
                                <c:if test="${empty sessionScope.MAPPING_MENTORS_ID}">
                                    <br/>
                                    <span class="text-danger">No mentor match!</span>
                                </c:if>
                                <br/>
                            </c:if>
                        </c:if>
                        <c:if test="${empty sessionScope.LIST_REQUEST}">
                            No request yet!<br/>
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
