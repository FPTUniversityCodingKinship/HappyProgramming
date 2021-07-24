<%-- 
    Document   : user_profile
    Created on : May 23, 2021, 11:23:43 AM
    Author     : DELL
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <c:set var="err" value="${requestScope.ERR}" scope="page"/>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile Management</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.css">
        <link rel="stylesheet" href="css/style.css">
    </head>
    <body>
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
        <c:if test="${sessionScope.CURRENT_USER.userID ne null}">
            <jsp:useBean id="userDao" class="hps.users.UsersDAO" scope="session"/>
            <c:set var="user" value="${userDao.getProfile(sessionScope.CURRENT_USER.userID)}"
                   scope="page"/>
            <div class="wrapper">
                <header>
                    <c:set var="id" value="${user.userID}"/>
                    <c:choose>
                        <c:when test="${fn:contains(id,'ME')}">
                            <c:set var="menu" value="mentee"/>
                        </c:when>
                        <c:when test="${fn:contains(id,'MT')}">
                            <c:set var="menu" value="mentor"/>
                        </c:when>
                        <c:when test="${fn:contains(id,'AD')}">
                            <c:set var="menu" value="admin"/>
                        </c:when>
                    </c:choose>
                    <jsp:include flush="true" page="${menu}/${menu}Menu.jsp"/>
                </header>
                <main>
                    <div id="content" class="form-group">
                        <jsp:include flush="true" page="/topMenu.jsp"/>
                         <h1>Your Profile</h1>
                        <form action="UpdateProfileController" enctype="multipart/form-data" method="POST">
                            <div class="container">
                                <div class="row">
                                    <div class="col col-md-3">
                                        Avatar: 
                                        <br />
                                        <img class="img-thumbnail" src="./images/${user.image}" 
                                             alt="The user's avatar"><br />
                                        <input type="hidden" name="txtUserImg" value="${user.image}" />
                                    </div>
                                    <div class="col col-md-4" style="margin-bottom: 3%">
                                        Update your avatar here: <input type="file" class="form-control-file" name="imageFile"/>
                                        User ID: ${user.userID}<br />
                                        <input type="hidden" name="txtUserID" value="${user.userID}" />
                                        <font color="red">
                                        ${err.usernameLengthErr}
                                        </font>
                                        <font color="red">
                                        ${err.usernameIsExisted}
                                        </font>
                                        <br />
                                        Username: <input type="text" class="form-control" name="txtUsername" value="${user.username}" />
                                        <font color="red">
                                        ${err.passwordLengthErr}
                                        </font>
                                        <br />
                                        Password: <input type="text" class="form-control" name="txtPassword" value="${user.password}" />
                                        <br />
                                        Email: ${user.email}
                                        <br />
                                        <font color="red">
                                        ${err.fullnameLengthErr}
                                        </font>
                                        <br />
                                        Full name: <input type="text"  class="form-control" name="txtFullname" value="${user.fullname}" />
                                        <br />
                                        Phone: <input type="text"  class="form-control" name="txtPhone" value="${user.phone}" />
                                        <br />
                                        Address: <input type="text"  class="form-control" name="txtAddress" value="${user.address}" />
                                        <font color="red">
                                        ${err.dateOfBirthInvalidError}
                                        </font>
                                        <br />
                                        Date of Birth: <input type="date"  class="form-control" name="txtDob" value="${user.dob}" /><br />
                                        Sex: <select name="txtSex" class="form-select">
                                            <c:if test="${user.sex eq 'M'}">
                                                <option selected="true" value="M">Male</option>
                                                <option value="F">Female</option>
                                                <option value="X">Other</option>
                                            </c:if>
                                            <c:if test="${user.sex eq 'F'}">
                                                <option value="M">Male</option>
                                                <option selected="true" value="F">Female</option>
                                                <option value="X">Other</option>
                                            </c:if>
                                            <c:if test="${user.sex eq 'X'}">
                                                <option value="M">Male</option>
                                                <option value="F">Female</option>
                                                <option selected="true" value="X">Other</option>
                                            </c:if>
                                        </select><br />
                                        <div class="row text-success">
                                            <input type="submit" value="Update" name="btAction" class="btn btn-success"/>
                                            ${requestScope.UPDATE_STATUS}<br />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </main>
            </div>
        </c:if>
        <!--SCRIPTS GO HERE-->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
        <script src="https://cdn.tiny.cloud/1/uvrwnlarfgzt2bb56y6vdl6cb5mhfr6h5sl6tqnucb5yuvvu/tinymce/5/tinymce.min.js" referrerpolicy="origin"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.concat.min.js"></script>
        <script src="js/menu.js"></script>
    </body>
</html>
