<%-- 
    Document   : forgot_password
    Created on : Jun 20, 2021, 3:51:55 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reset Password Page</title>
        <link rel="stylesheet" href="css/general.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
        <script src="js/forgot_password.js"></script>
    </head>
    <body>
        <h1>RESET PASSWORD</h1>
        <div id="container"></div>
        <c:set var="errors" value="${requestScope.LOGIN_ERROR}"/>
        
        <c:if test="${param.type eq 'username'}">
        <p>Please Enter your username here to get your account:</p>
        <form method="POST" action="ResetPassword" class="form-horizontal">
            <div class="form-group">
                <label for="txtUsername" class="col-md-2 col-form-label col-form-label-lg">
                    Email
                </label>
                <div class="col-md-10">
                    <input type="text" name="txtUsername" id="txtUsername"
                       value="${param.txtUsername}" 
                       placeholder="Enter username" 
                       class="form-control form-control-md"/>
                </div>
                <c:if test="${not empty errors.usernameLengthErr}">
                <p style="color: red;">
                    ${errors.usernameLengthErr}
                </p>
                </c:if>
            </div>
            <div class="form-group">        
                <div class="col-offset-2 col-md-10">
                    <button type="submit" 
                            class="btn btn-lg btn-primary float-right">
                        Send Code
                    </button>
                </div>
            </div>
        </form>
        </c:if>
        <c:if test="${param.type eq 'email'}">
        <p>Please Enter your email here to get your account:</p>
        <form method="POST" action="ResetPassword" class="form-horizontal">
            <div class="form-group">
                <label for="txtEmail" class="col-md-2 col-form-label col-form-label-lg">
                    Email
                </label>
                <div class="col-md-10">
                    <input type="text" name="txtEmail" id="txtEmail"
                       value="${param.txtEmail}" 
                       placeholder="Enter email" 
                       class="form-control form-control-md"/>
                </div>
                <c:if test="${not empty errors.emailInvalid}">
                <p style="color: red;">
                    ${errors.emailInvalid}
                </p>
                </c:if>
            </div>
            <div class="form-group">        
                <div class="col-offset-2 col-md-10">
                    <button type="submit" 
                            class="btn btn-lg btn-primary float-right">
                        Send Code
                    </button>
                </div>
            </div>
        </form>
        </c:if>
        <c:if test="${empty param.type}">
            <h1>Something went wrong and we're trying to fix it</h1>
            <h1 hidden>Djtme thằng hamlon sửa url chi zạy</h1>
            <a href="guest_homepage.jsp">
                Back to Homepage...
            </a>
        </c:if>
    </body>
    <script>
        var params = location.href.split("?")[1];
        if (params !== null) {
            var name = params.split("=")[0];
            var value = params.split("=")[1];
            if (name === "type")
                switch(value) {
                    case "email":
                        break;
                    case "username":
                        break;
                    default:
                        alert("Something went wrong");
                }
        }
    </script>
</html>
