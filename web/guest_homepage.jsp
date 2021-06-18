<%-- 
    Document   : guest_homepage
    Created on : Jun 1, 2021, 5:06:06 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Happy Programming System</title>
        <link rel="stylesheet" href="css/general.css">
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
    <h1>Hello World!</h1>
</body>
</html>
