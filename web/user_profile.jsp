<%-- 
    Document   : user_profile
    Created on : May 23, 2021, 11:23:43 AM
    Author     : DELL
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <c:set var="user" value="${sessionScope.CURRENT_USER}"/>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile Management</title>
    </head>
    <body>
        <h1>Welcome, ${user.username}</h1>
        ${requestScope.UPDATE_STATUS}
        <form action="UpdateProfileController" enctype="multipart/form-data" method="POST">
            Avatar: <img src="./images/${user.image}" alt="The user's avatar"><br />
            <input type="file" name="imageFile"/><br />
            User ID: ${user.userID}<br />
            <input type="hidden" name="txtUserID" value="${user.userID}" />
            Username: <input type="text" name="txtUsername" value="${user.username}" /><br />
            Password: <input type="password" name="txtPassword" value="${user.password}" /><br />
            Email: ${user.email}<br />
            Full name: <input type="text" name="txtFullname" value="${user.fullname}" /><br />
            Phone: <input type="text" name="txtPhone" value="${user.phone}" /><br />
            Address: <input type="text" name="txtAddress" value="${user.address}" /><br />
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
