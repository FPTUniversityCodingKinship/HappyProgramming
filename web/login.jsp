<%-- 
    Document   : login
    Created on : May 22, 2021, 6:07:10 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <script src="https://apis.google.com/js/platform.js" async defer></script>
        <meta name="google-signin-client_id" content="401908117605-vofu7m8maarbv0c6remdnf8n1r568060.apps.googleusercontent.com">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="css/general.css">
        <link rel="stylesheet" href="css/login.css">
    </head>
    <body>
        <div class="container">
        <h1>LOG IN HERE!!!</h1>
        <!-- Google Login -->
        <div class="g-signin2" data-onsuccess="onSignIn"></div>
        <script>
            function onSignIn() {
                var auth2 = gapi.auth2.init();
                if (auth2.isSignedIn.get()) {
                    var profile = auth2.currentUser.get().getBasicProfile();
                    console.log('ID: ' + profile.getId());
                    console.log('Full Name: ' + profile.getName());
                    console.log('Given Name: ' + profile.getGivenName());
                    console.log('Family Name: ' + profile.getFamilyName());
                    console.log('Image URL: ' + profile.getImageUrl());
                    console.log('Email: ' + profile.getEmail());
                }
    
                //disable auto login for the next time login
                gapi.auth2.getAuthInstance().disconnect().then(function () {
                    var mainPath = "http://localhost:8084/HappyProgramming/LoginController";
                    document.location.href = mainPath + "?txtGmail=" + profile.getEmail();
                    console.log('Google auto login disabled.');
                });
            }
        </script>
        <!-- Login Form -->
        <c:set var="errors" value="${requestScope.LOGIN_ERROR}"/>
        <form method="POST" action="Login" class="form-horizontal">
            <div class="form-group">
                <label for="txtUsername" class="control-label col-sm-2">
                    Username:
                </label>
                <div class="col-sm-8">
                    <input type="text" name="txtUsername" id="txtUsername"
                       value="${param.txtUsername}" placeholder="Enter username"/>
                </div>
                <c:if test="${not empty errors.usernameLengthErr}">
                <p style="color: red;">
                    ${errors.usernameLengthErr}
                </p>
                </c:if>
            </div>
            <div class="form-group">
                <label for="txtPassword" class="control-label col-sm-2">
                    Password
                </label>
                <div class="col-sm-8">
                    <input type="password" name="txtPassword" id="txtPassword"
                           value="" placeholder="Enter Password"/>
                </div>
                <c:if test="${not empty errors.passwordLengthErr}">
                <p style="color: red;">
                    ${errors.passwordLengthErr}
                </p>
                </c:if>
                <c:if test="${not empty errors.loginInfoNotMatch}">
                <p>
                    ${errors.loginInfoNotMatch}
                </p>
                </c:if>
            </div>
            
            <div class="form-group">        
                <div class="col-sm-offset-2 col-sm-10">
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" name="chkCookie">
                            Remember me
                        </label>
                    </div>
                </div>
            </div>
            <div class="form-group">        
                <div class="col-sm-offset-2 col-sm-10">
                    <button type="submit" class="btn btn-primary">LOGIN</button>
                </div>
            </div>
        </form>
        <a href="ResetPassword">Forgot your password?</a>
        <a href="SignUpPage">Create new account</a>
    </div>
    </body>
</html>