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
        <style>
            *{
                box-sizing: border-box;
                padding: 1%;
                border-radius: 25px;
            }

        </style>
    </head>
    <body>
        <jsp:useBean id="userDao" class="hps.users.UsersDAO" scope="session"/>
        <c:set var="user" value="${userDao.getProfile(sessionScope.CURRENT_USER.userID)}"
               scope="page"/>
        <header>
            <nav>
                <form action="Login">
                    <input type="hidden" name="txtUsername" value="${user.username}" />
                    <input type="hidden" name="txtPassword" value="${user.password}" />
                    <input type="submit" value="Back" name="btAction"/>
                </form><br/>
            </nav>
        </header>
        <h1>Welcome, ${user.username}</h1>
        ${requestScope.UPDATE_STATUS}
        <form action="UpdateProfileController" enctype="multipart/form-data" method="POST">
            Avatar: <img src="./images/${user.image}" alt="The user's avatar" 
                         style="width:250x;height:300px; float: left;"><br />
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
            Password: <input type="password" name="txtPassword" value="${user.password}" /><br />
            Email: ${user.email}<br />
            <font color="red">
            ${err.fullnameLengthErr}
            </font><br />
            Full name: <input type="text" name="txtFullname" value="${user.fullname}" /><br />
            Phone: <input type="text" name="txtPhone" value="${user.phone}" /><br />
            Address: <input type="text" name="txtAddress" value="${user.address}" /><br />
            <font color="red">
            ${err.dateOfBirthInvalidError}
            </font><br />
            Date of Birth: <input type="text" name="txtDob" value="${user.dob}" /><br />
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
            <input type="submit" value="Update" name="btAction"/>


        </form>
    </body>
</html>
