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
    </head>
    <body>
        <c:set var="successVerify" value="${requestScope.SUCCESS_VERIFY}"/>
        <c:if test="${empty successVerify}">
            <c:if test="${empty requestScope.WRONG_VERIFY}">
                <span>We already send a verification  code to your email.</span>
            </c:if>
            <form action="VerifyCode" method="post">
                <input type="text" name="authCode" >
                <input type="submit" value="verify">
            </form>
            <c:if test="${not empty requestScope.WRONG_VERIFY}">
                ${requestScope.WRONG_VERIFY}
            </c:if>
        </c:if>
        <c:if test="${not empty successVerify}">
            <h1>
                Verified successfully!!!
            </h1>
            <p>
                Please wait <span id="countdown"></span> second
                to redirect to see amazing things...
            </p>
            <script>
                var count = 3;
                $(document).ready(function(){
                  while (count > 0) {
                      setTimeout(function() {
                          document.getElementById("countdown").innerHTML = count;
                          count--;
                      },1000);
                  }
                  if (count === 0) {
                      var path = "http://localhost:8084/HappyProgramming/LoginController";
                      window.location.href = path + "";
                  }
                });
            </script>
        </c:if>
    </body>
</html>
