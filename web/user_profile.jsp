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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
        <link rel="stylesheet" href="css/style.css"/>
    </head>
    <body>
        <jsp:useBean id="userDao" class="hps.users.UsersDAO" scope="session"/>
        <c:set var="user" value="${userDao.getProfile(sessionScope.CURRENT_USER.userID)}"
               scope="page"/>
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
            <div style="margin-bottom: 13%">
                <jsp:include flush="true" page="/topMenu.jsp" />
            </div>
            <form action="UpdateProfileController" enctype="multipart/form-data" method="POST">
                <div class="container-fluid wrapper">
                    <div class="col col-md-3 offset-md-3">
                        Avatar: 
                        <br />
                        <img class="img-thumbnail" src="./images/${user.image}" 
                             alt="The user's avatar"><br />
                        <input type="hidden" name="txtUserImg" value="${user.image}" />
                    </div>
                    <div class="col col-md-5" style="margin-bottom: 3%">
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
        </main>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>
    </body>
</html>
