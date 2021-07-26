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
        <link rel="icon" href="images/favicon.ico">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <link rel="stylesheet" href="css/general.css">
        <link rel="stylesheet" href="css/userVerification.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" integrity="sha512-iBBXm8fW90+nuLcSKlbmrPcLa0OT92xO1BIsZ+ywDWZCvqsWgccV3gFoRBv0z+8dLJgyAHIhR35VZc2oM/gI1w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        
    </head>
    <body>
        <c:if test="${empty sessionScope.CURRENT_USER}">
            <form action="Logout" id="Logout">
                <p id="Welcome" class="text-right" style="margin: 16px;">
                    <input type="submit" value="Logout" class="btn btn-outline-danger"/>
                </p>
            </form>
        </c:if>
        
        <c:set var="successVerify" value="${requestScope.SUCCESS_VERIFY}"/>
        <div class="float-center">
            <img alt="" src="images/main-logo.png" width="256">
            <c:if test="${empty successVerify}">
                <c:if test="${empty requestScope.WRONG_VERIFY}">
                    <p>We already sent a verification code to your email.</p>
                </c:if>
                <c:if test="${not empty requestScope.WRONG_VERIFY}">
                    <p class="error-text">${requestScope.WRONG_VERIFY}</p>
                </c:if>
                <form action="VerifyCode" method="POST" class="form-inline mx-sm-3">
                    <input class="form-control form-control-lg" maxlength="6"
                           type="text" name="authCode" >
                    <input class="btn btn-outline-success mx-sm-3"
                           type="submit" value="Verify">
                </form>
                <p style="margin-top: 24px;">
                    Did not receive the code? 
                    <a href="#">Resend it.</a>
                </p>
            </c:if>

            <c:if test="${not empty successVerify}">
                <h1>
                    Verified successfully!!!
                </h1>
                <p> 
                    Everything is almost done.
                    Please wait <span id="countdown"></span> second(s)
                    and you will be able to join in our amazing world.
                </p>
                <script>
                    var countdown = 3;
                    setInterval(function () {
                        if (countdown === 0) {
                            document.location = "/HappyProgramming";
                            countdown -= 1;
                        } else if (countdown > 0) {
                            document.getElementById('countdown').innerHTML = countdown;
                            countdown -= 1;
                        }
                    }, 1000);
                </script>
            </c:if>
        </div>
    </body>
</html>
