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
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Login Page</title>
        <link rel="icon" href="images/favicon.ico">
        <!-- External ref -->
        <script src="https://apis.google.com/js/platform.js" async defer></script>
        <meta name="google-signin-client_id" content="401908117605-vofu7m8maarbv0c6remdnf8n1r568060.apps.googleusercontent.com">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
        <script type="module"  src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js"></script>
        <!-- Local ref -->
        <link rel="stylesheet" href="css/general.css">
        <link rel="stylesheet" href="css/login.css">
        <link rel="stylesheet" href="css/header.css">
        <link rel="stylesheet" href="css/animated-background.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" integrity="sha512-iBBXm8fW90+nuLcSKlbmrPcLa0OT92xO1BIsZ+ywDWZCvqsWgccV3gFoRBv0z+8dLJgyAHIhR35VZc2oM/gI1w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <!-- Script ref -->
        <script src="js/login.js"></script>
    </head>
    <body>
        <!-- Header -->
        <nav class="navbar navbar-light w-100">
            <div class="navbar-brand">
                <a class="animated-logo" href="/HappyProgramming">
                    <img src="images/main-logo.png" alt=""
                         style="width: 64px; float: left; margin: -12px 12px 0 0;"/>
                </a>
            </div>
            <div class="bold-text text-right" id="headerLink">
                <a class="nav-link header-button" href="LoginPage">Log In</a>
                <a class="nav-link header-button" href="SignUpPage">Sign Up</a>
            </div>
            <div class="header-background" id="headerBackground"></div>
        </nav>
        
        <!-- Background -->
        <div class="animated-background">
            <canvas id="background"></canvas>
            <script src="js/animated-background.js"></script>
        </div>
        
        <!-- Login form -->
        <div class="frm-login scale-in-center">
            <div class="container">
                <h1 onmousedown="return false;">LOG IN HERE!!!</h1>

                <!-- Google Login -->
                <div class="g-signin2-container">
                    <div class="g-signin2" data-onsuccess="onSignIn"></div>
                </div>
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
                            var mainPath = "/HappyProgramming/Login";
                            document.location = mainPath + "?txtGmail=" + profile.getEmail();
                            console.log('Google auto login disabled.');
                        });
                    }
                </script>
                <div class="separator">
                    <div class="_line"></div>
                    <span>OR</span>
                    <div class="_line"></div>
                </div>

                <!-- Login Form -->
                <c:set var="errors" value="${requestScope.LOGIN_ERROR}"/>
                <form method="POST" action="Login" class="form-horizontal">
                    <div class="form-group">
                        <label for="txtUsername" class="col-md-4 col-form-label col-form-label-lg">
                            <i class="fas fa-user" style="margin-right: 12px;"></i>
                            Username:
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
                        <label for="txtPassword" class="col-md-4 col-form-label col-form-label-lg">
                            <i class="fas fa-key" style="margin-right: 12px;"></i>
                            Password:
                        </label>
                        <div class="col-md-10">
                            <input type="password" name="txtPassword" id="txtPassword"
                                   value="" placeholder="Enter Password"
                                   class="form-control form-control-md"/>
                        </div>
                        <c:if test="${not empty errors.passwordLengthErr}">
                            <p style="color: red;">
                                ${errors.passwordLengthErr}
                            </p>
                        </c:if>
                        <c:if test="${not empty errors.loginInfoNotMatch}">
                            <p style="color: red;">
                                ${errors.loginInfoNotMatch}
                            </p>
                        </c:if>
                    </div>
                    <div class="form-group">        
                        <div class="col-md-10">
                            <div class="checkbox">
                                <label class="col-form-label col-form-label-lg">
                                    <input type="checkbox" name="chkCookie" value="ON">
                                    Remember me
                                </label>
                            </div>
                        </div>
                        <div class="col-sm-offset-8 col-sm-10">
                            <p class="text-right">
                                Forgot your password?
                                <a href="ResetPasswordPage">
                                    <span>Reset now</span>
                                </a>
                            </p>
                        </div> 
                    </div>
                    <div class="form-group">        
                        <div class="col-offset-2 col-md-10">
                            <button type="submit" 
                                    class="btn btn-lg btn-primary float-right">
                                LOGIN
                            </button>
                        </div>
                    </div>
                </form>
                <div class="more-thing">
                    <p>
                        Wanting to join us?
                        <a href="SignUpPage">
                            <span>Create a new account now</span>
                        </a>
                    </p>
                </div>
            </div>
        </div>

    </body>
</html>