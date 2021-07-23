<%-- 
    Document   : mentee_rate
    Created on : May 28, 2021, 9:37:37 AM
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
        <title>Rate & Comment mentor</title>
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
                        <jsp:param name="page" value="rate"/>
                    </jsp:include>
                </header>
                <main>
                    <div id="content">
                        <jsp:include flush="true" page="/topMenu.jsp"/>
                        <h1>Rate Mentor</h1>
                        <c:if test="${not empty sessionScope.REQ_INFO_FOR_RATING}">
                            <label class="font-weight-bold">Please select the concluded request you want to rate</label>
                            <br/>
                            <c:set var="reqInfo" value="${sessionScope.REQ_INFO_FOR_RATING}"/>
                            <c:forEach var="entry" items="${reqInfo}">
                                <c:url var="url" value="MenteeRate">
                                    <c:param name="requestID" value="${entry.key}"/>
                                    <c:param name="mentorID" value="${fn:split(entry.value,',')[1]}"/>
                                </c:url>
                                <i class="fas fa-chevron-right"></i> &nbsp; 
                                <a href="${url}">${fn:split(entry.value,',')[0]}</a><br/>
                            </c:forEach>
                            <br/>
                            <c:if test="${not empty sessionScope.RATING_INFO}">
                                <c:set var="info" value="${sessionScope.RATING_INFO}"/>
                                <c:forEach var="entry" items="${reqInfo}">
                                    <c:if test="${entry.key == info[0]}">
                                        <label class="font-weight-bold mb-2">
                                            Title of this request: 
                                        </label>
                                        <span class="text-info">${fn:split(entry.value,',')[0]}<br/></span>
                                        </c:if>
                                    </c:forEach>
                                <form action="MenteeRate" method="POST">
                                    <c:set var="error" value="${requestScope.RATE_ERROR}"/>
                                    <input type="hidden" name="requestID" value="${info[0]}"/>
                                    <input type="hidden" name="menteeID" value="${info[1]}"/>
                                    <input type="hidden" name="mentorID" value="${info[2]}"/>

                                    <div class="form-group row">
                                        <div class="col-1">
                                            <label for="rate" class="font-weight-bold">Rate</label>
                                        </div>
                                        <div class="col-4">
                                            <input class="form-control" type="text" name="rate" value="${param.rate}" /><br/>
                                            <c:if test="${not empty error.rateOutOfBoundError}" >
                                                <font color="red">${error.rateOutOfBoundError}</font><br/>
                                            </c:if>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col-1">
                                            <label for="" class="font-weight-bold">Comment</label>
                                        </div>
                                        <div class="col-4">
                                            <textarea class="form-control" name="comments" rows="4" cols="30"></textarea><br/>
                                            <c:if test="${not empty error.commentLengthError}" >
                                                <font color="red">${error.commentLengthError}</font><br/>
                                            </c:if>
                                        </div>
                                    </div>
                                    <input class="btn btn-primary" type="submit" value="OK" /><br/>
                                    <c:if test="${not empty error.ratedError}" >
                                        <font color="red">${error.ratedError}</font><br/>
                                    </c:if>
                                </form>
                            </c:if>
                        </c:if>
                        <c:if test="${empty sessionScope.REQ_INFO_FOR_RATING}">
                            No concluded request yet for rating!<br/>
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
