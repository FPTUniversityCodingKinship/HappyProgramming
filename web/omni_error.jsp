<%-- 
    Document   : omni_error
    Created on : Jul 22, 2021, 6:54:02 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
    <head>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.css">
        <title>Error...</title>
    </head>
</head>
<body>
    <div>
        <c:if test="${fn:contains(sessionScope.CURRENT_USER.userID, 'ME')}">
            <h1 class="text-danger">
                An unexpected error has happened! Redirecting <span id='countdown'>2</span>...
            </h1>
            <script>
                var countdown = 2;
                setInterval(function () {
                    if (countdown <= 0) {
                        document.location = "/HappyProgramming/MenteeCreateRequestPage";
                    }
                    document.getElementById('countdown').innerHTML = countdown;
                    countdown -= 1;
                }, 1000);
            </script>
        </c:if>
        <c:if test="${fn:contains(sessionScope.CURRENT_USER.userID, 'MT')}">
            <h1 class="text-danger">
                An unexpected error has happened! Redirecting <span id='countdown'>2</span>...           
            </h1>
            <script>
                var countdown = 2;
                setInterval(function () {
                    if (countdown <= 0) {
                        document.location = "/HappyProgramming/FollowingRequest";
                    }
                    document.getElementById('countdown').innerHTML = countdown;
                    countdown -= 1;
                }, 1000);
            </script>
        </c:if>
        <c:if test="${fn:contains(sessionScope.CURRENT_USER.userID, 'AD')}">
            <h1 class="text-warning">
                An unexpected error has happened! Redirecting <span id='countdown'>2</span>...           
            </h1>
            <script>
                var countdown = 2;
                setInterval(function () {
                    if (countdown <= 0) {
                        document.location = "/HappyProgramming/AdminViewRequestsListPage";
                    }
                    document.getElementById('countdown').innerHTML = countdown;
                    countdown -= 1;
                }, 1000);
            </script>
        </c:if>
        <c:if test="${sessionScope.CURRENT_USER.userID eq null}">
            <h1 class="text-warning">
                An unexpected error has happened! Redirecting <span id='countdown'>2</span>...           
            </h1>
            <script>
                var countdown = 2;
                setInterval(function () {
                    if (countdown <= 0) {
                        document.location = "/HappyProgramming/HomePage";
                    }
                    document.getElementById('countdown').innerHTML = countdown;
                    countdown -= 1;
                }, 1000);
            </script>
        </c:if>
    </div>
</body>
</html>
