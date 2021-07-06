<%-- 
    Document   : userVerification
    Created on : Jun 14, 2021, 12:41:49 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Email Verify Page</title>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <link rel="stylesheet" href="css/general.css">
    </head>
    <body>
        <c:if test="${not empty sessionScope.CURRENT_USER}">
            <form action="Logout" method="POST" id="Logout">
                <p id="Welcome">
                    <input type="submit" value="Logout" class="btn"/>
                </p>
            </form>
        </c:if>
        <c:set var="successVerify" value="${requestScope.SUCCESS_VERIFY}"/>
        <c:if test="${empty successVerify}">
            <c:if test="${empty requestScope.WRONG_VERIFY}">
                <span>We already send a verification  code to your email.</span>
            </c:if>
            <c:if test="${not empty requestScope.WRONG_VERIFY}">
                <span class="error-text">${requestScope.WRONG_VERIFY}</span>
            </c:if>
            <form action="VerifyCode" method="post">
                <input type="text" name="authCode" >
                <input type="submit" value="verify">
            </form>
        </c:if>
        <c:if test="${not empty successVerify}">
            <h1>
                Verified successfully!!!
            </h1>
            <p>
                Please wait <span id="countdown"></span> second
                to redirect to see amazing things...
            </p>
            <c:set var="txtGmail" value="${requestScope.TO_LOGIN_MAIL}"/>
            <script>
                $(document).ready(function(){
                    var params = window.location.href.split("?")[1];
                    var countDown = document.getElementById("countdown");
                    countDown.innerHTML = '3';
                    setTimeout(function() {
                        countDown.innerHTML = '2';
                        setTimeout(function () {
                            countDown.innerHTML = '1';
                            setTimeout(function () {
                                countDown.innerHTML = '0';
                                var origin = window.location.origin;
                                window.location.href = origin + 
                                        "/HappyProgramming/Login?" + params;
                            }, 1000);
                        }, 1000);
                    }, 1000);
                });
            </script>
        </c:if>
    </body>
</html>
