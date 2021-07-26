<%-- 
    Document   : signup
    Created on : May 23, 2021, 6:56:28 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Account</title>
        <link rel="icon" href="images/favicon.ico">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
        <script type="module"  src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" integrity="sha512-iBBXm8fW90+nuLcSKlbmrPcLa0OT92xO1BIsZ+ywDWZCvqsWgccV3gFoRBv0z+8dLJgyAHIhR35VZc2oM/gI1w==" crossorigin="anonymous" referrerpolicy="no-referrer" />

        <link rel="stylesheet" href="css/general.css">
        <link rel="stylesheet" href="css/signup.css">
        <link rel="stylesheet" href="css/header.css">
        <link rel="stylesheet" href="css/animated-background.css">

        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    </head>
    <body>
        <!-- Header -->
        <nav class="navbar navbar-light w-100">
            <div class="navbar-brand">
                <a class="animated-logo" href="/HappyProgramming">
                    <img src="images/main-logo.png" alt=""
                         style="width: 64px; float: left; margin: -12px 12px 0 0;"/>
                </a>
                <a href="/HappyProgramming" style="text-decoration: none;">
                    <p class="h1 bold-text" style="color: #fff" id="headerName">
                        HAPPY PROGRAMMING
                    </p>
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

        <!-- Signup form -->
        <div class="frm-signup scale-in-center">
            <div class="container">
                <h1>JOIN OUR COMMUNITY NOW!!!</h1>
                <hr>
                <c:set var="errors" value="${requestScope.CREATE_ERROR}"/>
                <c:if test="${not empty errors}">
                    <style>
                        body {
                            height: 2200px;
                        }
                        .frm-signup {
                            height: 1480px;
                        }
                    </style>
                </c:if>
                <form action="SignUp" method="POST" class="form-horizontal">
                    <c:if test="${not empty errors.userIDFailedToGenerate}">
                        <p style="color: red;">
                            ${errors.userIDFailedToGenerate}
                            </>
                        </c:if>
                        <%-- Email --%>
                    <div class="form-group">
                        <label for="txtEmail" class="col-md-4 col-form-label col-form-label-lg">

                            Email<span style="color: red">*</span>:
                        </label>                                
                        <div class="col-md-10">
                            <input type="email" name="txtEmail" id="txtEmail"
                                   value="${param.txtEmail}"
                                   placeholder=" (example@gmail.com)"
                                   class="form-control form-control-md"/>
                        </div>
                        <c:if test="${not empty errors.emailInvalid}">
                            <p style="color: red;">
                                ${errors.emailInvalid}
                            </p>
                        </c:if>
                        <c:if test="${not empty errors.emailIsExisted}">
                            <p style="color: red;">
                                ${errors.emailIsExisted}
                            </p>
                        </c:if>
                    </div>
                    <%-- Username --%>
                    <div class="form-group">
                        <label for="txtUsername" class="col-md-4 col-form-label col-form-label-lg">

                            Username<span style="color: red">*</span>:
                        </label>
                        <div class="col-md-10">
                            <input type="text" name="txtUsername" id="txtUsername"
                                   value="${param.txtUsername}" 
                                   placeholder=" (6-30 chars | letters, numbers)" 
                                   class="form-control form-control-md"/>
                        </div>
                        <c:if test="${not empty errors.usernameLengthErr}">
                            <p style="color: red;">
                                ${errors.usernameLengthErr}
                            </p>
                        </c:if>
                        <c:if test="${not empty errors.usernameIsExisted}">
                            <p style="color: red;">
                                ${errors.usernameIsExisted}
                            </p>
                        </c:if>
                    </div>
                    <%-- Password --%>
                    <div class="form-group">
                        <label for="txtPassword" class="col-md-4 col-form-label col-form-label-lg">

                            Password<span style="color: red">*</span>:
                        </label>
                        <div class="col-md-10">
                            <input type="password" name="txtPassword"
                                   id="txtPassword" value=""
                                   placeholder=" (6-20 chars | letters, numbers)"
                                   class="form-control form-control-md"/>
                        </div>
                        <c:if test="${not empty errors.passwordLengthErr}">
                            <p style="color: red;">
                                ${errors.passwordLengthErr}
                            </p>
                        </c:if>
                    </div>
                    <%-- Confirm Password --%>
                    <div class="form-group">
                        <label for="txtConfirm" class="col-md-4 col-form-label col-form-label-lg">

                            Confirm Password<span style="color: red">*</span>:
                        </label>
                        <div class="col-md-10">
                            <input type="password" name="txtConfirm"
                                   id="txtConfirm" value=""
                                   placeholder=" (matching the password)"
                                   class="form-control form-control-md"/>
                        </div>
                        <c:if test="${not empty errors.confirmNotMatch}">
                            <p style="color: red;">
                                ${errors.confirmNotMatch}
                            </p>
                        </c:if>
                    </div>
                    <%-- Fullname --%>
                    <div class="form-group">
                        <label for="txtFullname" class="col-md-4 col-form-label col-form-label-lg">

                            Full Name<span style="color: red">*</span>:
                        </label>
                        <div class="col-md-10">
                            <input type="text" name="txtFullname"
                                   id="txtFullname" value="${param.txtFullname}"
                                   placeholder=" (2-50 chars | letters, spaces)"
                                   class="form-control form-control-md"/>
                        </div>
                        <c:if test="${not empty errors.fullnameLengthErr}">
                            <p style="color: red;">
                                ${errors.fullnameLengthErr}
                            </p>
                        </c:if>
                    </div>
                    <%-- Sex --%>
                    <div class="form-group">
                        <label for="txtSex" class="col-md-4 col-form-label col-form-label-lg">

                            Sex<span style="color: red">*</span>:
                        </label>
                        <br/>
                        <div class="" style="margin-left: 3%;">
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="txtSex" id="fmale" value="F" checked>
                                <label class="form-check-label" for="fmale">Female</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="txtSex" id="male" value="M">
                                <label class="form-check-label" for="male">Male</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="txtSex" id="other" value="X">
                                <label class="form-check-label" for="other">Other</label>
                            </div>
                        </div>

                        <c:if test="${not empty errors.fullnameLengthErr}">
                            <p style="color: red;">
                                ${errors.fullnameLengthErr}
                            </p>
                        </c:if>
                    </div>
                    <%-- Birthday --%>
                    <div class="form-group">
                        <label for="txtDob" class="col-md-4 col-form-label col-form-label-lg">

                            Birthday<span style="color: red">*</span>:
                        </label>
                        <div class="col-md-10">
                            <input type="date" name="txtDob" id="txtDob"
                                   value="${param.txtDob}"
                                   class="form-control form-control-md"/>
                        </div>
                        <c:if test="${not empty errors.dobInvalid}">
                            <p style="color: red;">
                                ${errors.dobInvalid}
                            </p>
                        </c:if>
                    </div>
                    <%-- Address --%>
                    <div class="form-group">
                        <label for="txtAddress" class="col-md-4 col-form-label col-form-label-lg">

                            Address<span style="color: red">*</span>:
                        </label>
                        <div class="col-md-10">
                            <input type="text" name="txtAddress"
                                   id="txtAddress" value="${param.txtAddress}"
                                   placeholder=" (..., province/state, country)"
                                   class="form-control form-control-md"/>
                        </div>
                        <c:if test="${not empty errors.addressInvalid}">
                            <p style="color: red;">
                                ${errors.addressInvalid}
                            </p>
                        </c:if>
                    </div>
                    <%-- Phone Number --%>
                    <div class="form-group">
                        <label for="txtPhone" class="col-md-4 col-form-label col-form-label-lg">

                            Phone<span style="color: red">*</span>:
                        </label>
                        <div class="col-md-10">
                            <input type="text" name="txtPhone"
                                   id="txtPhone" value="${param.txtPhone}"
                                   placeholder=" (9-12 digits)"
                                   class="form-control form-control-md"/>
                        </div>
                        <c:if test="${not empty errors.phoneInvalid}">
                            <p style="color: red;">
                                ${errors.phoneInvalid}
                            </p>
                        </c:if>
                    </div>
                    <hr>
                    <div class="form-group">        
                        <div class="col-offset-2 col-md-10">
                            <button type="submit" 
                                    class="btn btn-lg btn-primary float-left">
                                Create new Account
                            </button>
                        </div>
                    </div>
                    <div class="form-group">        
                        <div class="col-offset-2 col-md-10">
                            <button type="reset" 
                                    class="btn btn-lg btn-outline-danger float-right">
                                Reset
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </body>
    <script src="js/signup.js"></script>
</html>
