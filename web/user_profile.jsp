<%-- 
    Document   : user_profile
    Created on : May 23, 2021, 11:23:43 AM
    Author     : DELL
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <c:set var="err" value="${requestScope.ERR}" scope="page"/>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>
    </head>
    <body>
        <header>
            <nav class="navbar navbar-light " style="background: #003648;">

                <a class="navbar-brand ps-5">
                    <img src="./images/logo.png" alt="" width="96" height="64">
                </a>
                <div style="margin-left: 60%">
                    <form action="Login">
                        <input type="hidden" name="txtUsername" value="${user.username}" />
                        <input type="hidden" name="txtPassword" value="${user.password}" />
                        <input type="submit" value="Home" name="btAction" 
                               class="btn btn-danger" />
                    </form>
                </div>
                <br/>
            </nav>
        </header>
        <jsp:useBean id="userDao" class="hps.users.UsersDAO" scope="session"/>
        <c:set var="user" value="${userDao.getProfile(sessionScope.CURRENT_USER.userID)}"
               scope="page"/>
        <div class="container-fluid wrapper" style="background: #006789">
            <div class="row">
                <div class="col-md-2 bg-primary">
                    <div class="px-4" style="height: 100vh; text-align: left;">
                        <h3 class="text-center text-light">Welcome, ${user.username}</h3>
                    </div>
                </div>
                <div class="col-md-10 bg-light ">
                    <form action="UpdateProfileController" enctype="multipart/form-data" method="POST">
                        <div class="row">
                            <div class="col-md-4 offset-md-1 mt-5" >
                                Avatar: 
                                <br />
                                <img class="img-thumbnail" src="./images/${user.image}" 
                                     alt="The user's avatar"><br />
                                <input type="hidden" name="txtUserImg" value="${user.image}" />
                            </div>
                            <div class="col-md-5 offset-md-1 mt-5">
                                Update your avatar here: <input type="file" name="imageFile"/><br />
                                User ID: ${user.userID}<br />
                                <input type="hidden" name="txtUserID" value="${user.userID}" />
                                <font color="red">
                                ${err.usernameLengthErr}
                                </font>
                                <font color="red">
                                ${err.usernameIsExisted}
                                </font><br />
                                Username: <input type="text" name="txtUsername" value="${user.username}" /><br />
                                <font color="red">
                                ${err.passwordLengthErr}
                                </font><br />
                                Password: <input type="text" name="txtPassword" value="${user.password}" /><br />
                                </font><br />
                                Email: ${user.email}<br />
                                <font color="red">
                                ${err.fullnameLengthErr}
                                </font><br />
                                Full name: <input type="text" name="txtFullname" value="${user.fullname}" /><br />
                                <br />
                                Phone: <input type="text" name="txtPhone" value="${user.phone}" /><br />
                                <br />
                                Address: <input type="text" name="txtAddress" value="${user.address}" /><br />
                                <font color="red">
                                ${err.dateOfBirthInvalidError}
                                </font><br />
                                Date of Birth: <input type="text" name="txtDob" value="${user.dob}" /><br />
                                <br />
                                Sex: <select name="txtSex">
                                    <c:if test="${user.sex eq 'M'}">
                                        <option selected="true">M</option>
                                        <option>F</option>
                                        <option>X</option>
                                    </c:if>
                                    <c:if test="${user.sex eq 'F'}">
                                        <option>M</option>
                                        <option selected="true">F</option>
                                        <option>X</option>
                                    </c:if>
                                    <c:if test="${user.sex eq 'X'}">
                                        <option>M</option>
                                        <option>F</option>
                                        <option selected="true">X</option>
                                    </c:if>
                                </select><br />
                                <br />
                                <div class="row text-success">
                                    <input type="submit" value="Update" name="btAction" class="btn btn-success"/>
                                    ${requestScope.UPDATE_STATUS}<br />
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
