<%-- 
    Document   : mentee_statisticRequest
    Created on : May 26, 2021, 3:14:41 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.css">
        <link rel="stylesheet" href="css/style.css">
        <title>Statistic of requests</title>
    </head>
    <body>
        <jsp:useBean id="userDao" class="hps.users.UsersDAO" scope="session"/>
        <c:set var="user" value="${userDao.getProfile(sessionScope.CURRENT_USER.userID)}"
               scope="page"/>
<!--        <header>
            <nav>
                <form action="Login">
                    <input type="hidden" name="txtUsername" value="${user.username}" />
                    <input type="hidden" name="txtPassword" value="${user.password}" />
                    <input type="submit" value="Back" name="btAction"/>
                </form><br/>
            </nav>
        </header>-->
        <c:if test="${empty user}">
            <c:redirect url="LoginPage" />
        </c:if>
        <c:if test="${not fn:startsWith(user.userID, 'ME')}">
            <c:redirect url="/" />
        </c:if>
        <div class="wrapper">
            <header>
                <!--Menu-->
                <jsp:include flush="true" page="menteeMenu.jsp">
                    <jsp:param name="page" value="statisticRequest"/>
                </jsp:include>
            </header>
            <main>
                <div id="content">
                    <jsp:include flush="true" page="/topMenu.jsp"/>
                    <h1>Statistic Request</h1>
                    <c:if test="${not empty sessionScope.CURRENT_USER}">
                        <c:set var="user" value="${sessionScope.CURRENT_USER}"/>
                        Mentee ID: ${user.userID}<br/>
                    </c:if>
                    <c:if test="${not empty requestScope.REQUESTS_TITLE}" >
                        Title of requests: 
                        <c:set var="titles" value="${requestScope.REQUESTS_TITLE}" />
                        <c:forEach var="title" items="${titles}">
                            ${title},
                        </c:forEach> 
                    </c:if>
                    <c:if test="${empty requestScope.REQUESTS_TITLE}">
                        Title of requests: (No request yet)
                    </c:if><br/>
                    <c:if test="${not empty requestScope.TOTAL_REQUEST}" >
                        Total of request: ${requestScope.TOTAL_REQUEST}
                    </c:if><br/>
                    <c:if test="${not empty requestScope.TOTAL_HOUR}" >
                        Total of hours of all request: ${requestScope.TOTAL_HOUR}
                    </c:if><br/>
                    <c:if test="${not empty requestScope.TOTAL_MENTOR}" >
                        Total mentor: ${requestScope.TOTAL_MENTOR}
                    </c:if>
                </div>
            </main>
        </div>
                    
            
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
        <script src="https://cdn.tiny.cloud/1/uvrwnlarfgzt2bb56y6vdl6cb5mhfr6h5sl6tqnucb5yuvvu/tinymce/5/tinymce.min.js" referrerpolicy="origin"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.concat.min.js"></script>
        <script src="js/menu.js"></script>
    </body>
</html>
