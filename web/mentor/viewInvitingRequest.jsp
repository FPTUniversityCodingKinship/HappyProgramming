<%-- 
    Document   : viewInvitingRequest.jsp
    Created on : May 23, 2021, 8:24:14 PM
    Author     : Tran Phong <phongntse150974@fpt.edu.vn>
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="x-ua-compatible" content="ie=edge">

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.css">
        <link rel="stylesheet" href="css/style.css">
        <title>Inviting Requests</title>
    </head>
    <body>
        <c:if test="${fn:contains(sessionScope.CURRENT_USER.userID, 'ME')}">
            <h1 class="text-warning">
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
        <c:if test="${fn:contains(sessionScope.CURRENT_USER.userID, 'AD')}">
            <h1 class="text-warning">
                Unauthorised access detected! Redirecting <span id='countdown'>2</span>...           
            </h1>
            <script>
                var countdown = 2;
                setInterval(function () {
                    if (countdown <= 0){
                        document.location = "AdminViewRequestsListPage";
                    }
                    document.getElementById('countdown').innerHTML = countdown;
                    countdown -= 1;
                    
                }, 1000);
            </script>
        </c:if>
        <c:if test="${fn:contains(sessionScope.CURRENT_USER.userID, 'MT')}">
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
                    <jsp:param name="page" value="viewInvited"/>
                </jsp:include>
            </header>

            <main>
                <div id="content">
                    <jsp:include flush="true" page="/topMenu.jsp"/>
                    <h1>Requests from the Mentees who invited you to be their Mentor</h1>
                    <div class="row">
                        <div class="col-8">
                            <c:set var="error" value="${requestScope.FOLLOWING_ERROR}" />
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger" role="alert">
                                    ${error}
                                </div>
                            </c:if>
                            <c:if test="${empty error}">
                                <c:set var="requestsList" value="${requestScope.INVITING_REQUESTS}" />
                                <c:if test="${empty requestsList}">
                                    There is no request that is from the mentees who invited you to be their Mentor...
                                </c:if>
                                <c:if test="${not empty requestsList}">
                                    <table class='table table-bordered table-hover table-responsive'>
                                        <thead class='thead-light'>
                                            <tr>
                                                <th class="align-middle" scope='col'>No.</th>
                                                <th class="align-middle" scope='col'>From Mentee</th>
                                                <th class="align-middle" scope='col'>Title</th>
                                                <th class="align-middle" scope='col'>Deadline date</th>
                                                <th class="align-middle" scope='col'>Deadline hour</th>
                                                <th class="align-middle" scope='col'>Content</th>
                                                <th class="align-middle" scope='col'>Skills</th>
                                                <th class="align-middle" scope='col'>Status</th>
                                                <th class="align-middle" scope='col'>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <jsp:useBean id="skillsDAO" class="hps.skills.SkillsDAO" />
                                            <jsp:useBean id="usersDAO" class="hps.users.UsersDAO" />

                                            <c:forEach items="${requestsList}" var="request" varStatus="count">
                                                <c:set var="listSkillsID" value="${request.skillsID}" />
                                                <c:set var="listSkills" value="${skillsDAO.getSkillsList(listSkillsID)}" />
                                                <tr>
                                                    <td class="align-middle" scope='row'>
                                                        ${count.count}
                                                    </td>
                                                    <td class="align-middle">
                                                        <c:set var="menteeInfo" value="${usersDAO.getUserData(request.menteeID)}" />
                                                        ${menteeInfo.fullname}
                                                    </td>
                                                    <td class="align-middle">
                                                        ${request.title}
                                                    </td>
                                                    <td class="align-middle">
                                                        ${(fn:split(request.deadline, " " ))[0]}
                                                    </td>
                                                    <td class="align-middle">
                                                        ${(fn:split(request.deadline, " " ))[1]}
                                                    </td>
                                                    <td class="align-middle">
                                                        ${request.reqContent}
                                                    </td>
                                                    <td class="align-middle">
                                                        <c:forEach items="${listSkills}" var="skill" varStatus="count">
                                                            <c:if test="${count.count eq 1}">${fn:trim(skill.skillName)}</c:if>
                                                            <c:if test="${count.count ne 1}">, ${fn:trim(skill.skillName)}</c:if>
                                                        </c:forEach>
                                                    </td>

                                                    <c:if test="${request.status eq 'P'}">
                                                        <td class="align-middle">
                                                            <span class="badge badge-info p-2">Pending</span>
                                                            <!--                                                            <font color="purple">Pending</font>-->
                                                        </td>
                                                        <td class="align-middle">
                                                            <c:url var="approveURL" value="Approve">
                                                                <c:param name="requestID" value="${request.requestID}" />
                                                                <c:param name="mentorID" value="${user.userID}" />
                                                                <c:param name="redirect" value="FollowingRequest" />
                                                            </c:url>
                                                            <a class='btn btn-outline-primary d-block' href="${approveURL}">Approve</a>
                                                            <c:url var="rejectURL" value="Reject">
                                                                <c:param name="requestID" value="${request.requestID}" />
                                                                <c:param name="mentorID" value="${user.userID}" />
                                                                <c:param name="redirect" value="FollowingRequest" />
                                                            </c:url>
                                                            <a class='btn btn-outline-danger d-block mt-2' href="${rejectURL}">Reject</a>
                                                        </td>
                                                    </c:if>
                                                    <c:if test="${request.status eq 'A'}">
                                                        <td class="align-middle">
                                                            <span class="badge badge-primary p-2">Approved</span>
                                                            <!--                                                            <font color="purple">Approved - Processing</font>-->
                                                        </td>
                                                        <td class="align-middle">
                                                            <c:url var="closeURL" value="Close">
                                                                <c:param name="requestID" value="${request.requestID}" />
                                                                <c:param name="redirect" value="FollowingRequest" />
                                                            </c:url>
                                                            <a class='btn btn-outline-success' href="${closeURL}">Closed</a>
                                                        </td>
                                                    </c:if>


                                                </tr> 
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </c:if>

                                <c:if test="${not empty requestScope.REJECT_ERROR}">
                                    <div class="alert alert-danger" role="alert">
                                        ${requestScope.REJECT_ERROR}
                                    </div>
                                </c:if>
                                <c:if test="${not empty requestScope.APPROVE_ERROR}">
                                    <div class="alert alert-danger" role="alert">
                                        ${requestScope.APPROVE_ERROR}
                                    </div>
                                </c:if>
                                <c:if test="${not empty requestScope.CLOSE_ERROR}">
                                    <div class="alert alert-danger" role="alert">
                                        ${requestScope.CLOSE_ERROR}
                                    </div>
                                </c:if>
                            </c:if>
                        </div>
                        <div class="col-4">

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
