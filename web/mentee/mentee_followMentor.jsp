<%-- 
    Document   : mentee_followMentor
    Created on : Jun 22, 2021, 6:50:47 PM
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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.css">
        <link rel="stylesheet" href="css/style.css">
        <title>Follow mentor</title>
    </head>
    <body>
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
                <header>
                    <!--Menu-->
                    <jsp:include flush="true" page="menteeMenu.jsp">
                        <jsp:param name="page" value="followMentor"/>
                    </jsp:include>
                </header>
                <main>
                    <div id="content">
                        <jsp:include flush="true" page="/topMenu.jsp"/>
                        <h1>Follow Mentor</h1>
                        <c:if test="${not empty sessionScope.MENTOR_LIST}">
                            <c:set var="mentorList" value="${sessionScope.MENTOR_LIST}"/>
                            <c:set var="professionList" value="${sessionScope.PROFESSION_LIST}"/>
                            <c:set var="followedMentors" value="${sessionScope.FOLLOWED_MENTORS}"/>
                            <table class='table table-bordered table-hover'>
                                <thead class='thead-light'>
                                    <tr>
                                        <th>No</th>
                                        <th>Full name</th>
                                        <th>Account name</th>
                                        <th>Profession</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="mentor" items="${mentorList}" varStatus="counter">
                                        <tr>
                                            <td>
                                                ${counter.count}
                                            </td>
                                            <td>
                                                ${mentor.fullname}
                                            </td>
                                            <td>
                                                ${mentor.username}
                                            </td>
                                            <td>
                                                <c:forEach var="profession" items="${professionList}">
                                                    <c:if test="${mentor.userID eq profession['key']}">
                                                        ${profession['value']}
                                                    </c:if>
                                                </c:forEach>
                                            </td>
                                            <td>
                                                <c:if test="${fn:contains(followedMentors, mentor.userID)}">
                                                    Following  
                                                </c:if>
                                                <c:if test="${not fn:contains(followedMentors, mentor.userID)}">
                                                    Not Following    
                                                </c:if>
                                            </td>
                                            <td>
                                                <c:if test="${fn:contains(followedMentors, mentor.userID)}">
                                                    <c:url var="url" value="MenteeCreateFollow">
                                                        <c:param name="menteeID" value="${sessionScope.CURRENT_USER.userID}"/>
                                                        <c:param name="mentorID" value="${mentor.userID}"/>
                                                        <c:param name="status" value="0"/>
                                                    </c:url>
                                                    <a class="btn btn-danger" href="${url}">Unfollow</a>
                                                </c:if>
                                                <c:if test="${not fn:contains(followedMentors, mentor.userID)}">
                                                    <c:url var="url" value="MenteeCreateFollow">
                                                        <c:param name="menteeID" value="${sessionScope.CURRENT_USER.userID}"/>
                                                        <c:param name="mentorID" value="${mentor.userID}"/>
                                                        <c:param name="status" value="1"/>
                                                    </c:url>
                                                    <a class="btn btn-success" href="${url}">Follow</a>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>

                        </c:if>
                    </div>
                </main>
            </div>
        </c:if>

    </body>

</html>
