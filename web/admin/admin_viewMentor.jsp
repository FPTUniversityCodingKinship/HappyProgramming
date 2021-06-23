<%-- 
    Document   : admin_viewMentor
    Created on : May 31, 2021, 3:49:03 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.css">
        <title>View all mentor</title>
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
        <div class="wrapper">
            <header>
                <!--Menu-->
                <jsp:include flush="true" page="adminMenu.jsp">
                    <jsp:param name="page" value="viewAllMentor"/>
                </jsp:include>
            </header>
            <main>
                <div id="content">
                    <jsp:include flush="true" page="/topMenu.jsp"/>
                    <h1>View All Mentor</h1>
                    <form action="AdminViewMentor" method="POST">
                        <input type="text" name="searchValue" value="${param.searchValue}" />
                        <input type="submit" value="Search" /><br/>
                    </form>
                    <br/>
                    <c:if test="${not empty sessionScope.MENTOR_INFO}">
                        <c:set var="listMentorInfo" value="${sessionScope.MENTOR_INFO}"/>
                        <table class='table table-bordered table-hover'>
                            <thead class='thead-light'>
                                <tr>
                                    <th>STT</th>
                                    <th>ID</th>
                                    <th>Full name</th>
                                    <th>Account name</th>
                                    <th>Profession</th>
                                    <th># Accepted requests</th>
                                    <th>Percentage completed (%)</th>
                                    <th>Rate star</th>
                                    <th>Status</th>
                                    <th>Active/Inactive</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="mentorInfo" items="${listMentorInfo}" varStatus="counter">
                                    <tr>
                                        <td>
                                            ${counter.count}
                                        </td>
                                        <td>
                                            ${mentorInfo['key']}
                                        </td>
                                        <td>
                                            ${fn:split(mentorInfo['value'],',')[0]}
                                        </td>
                                        <td>
                                            ${fn:split(mentorInfo['value'],',')[1]}
                                        </td>
                                        <td>
                                            ${fn:split(mentorInfo['value'],',')[2]}
                                        </td>
                                        <td>
                                            ${fn:split(mentorInfo['value'],',')[3]}
                                        </td>
                                        <td>
                                            ${fn:split(mentorInfo['value'],',')[4]}
                                        </td>
                                        <td>
                                            ${fn:split(mentorInfo['value'],',')[5]}
                                        </td>
                                        <td>  
                                            <c:if test="${fn:split(mentorInfo['value'],',')[6] eq '1'}">Active</c:if>
                                            <c:if test="${fn:split(mentorInfo['value'],',')[6] eq '0'}">Inactive</c:if>
                                        </td>
                                        <td>
                                            <c:url var="url1" value="AdminManageMentorStatus">
                                                <c:param name="searchValue" value="${param.searchValue}"/>
                                                <c:param name="mentorID" value="${mentorInfo['key']}"/>
                                                <c:param name="status" value="1"/>
                                            </c:url>
                                            <a href="${url1}" style="text-decoration: underline">Active</a> /
                                            <c:url var="url2" value="AdminManageMentorStatus">
                                                <c:param name="searchValue" value="${param.searchValue}"/>
                                                <c:param name="mentorID" value="${mentorInfo['key']}"/>
                                                <c:param name="status" value="0"/>
                                            </c:url>
                                            <a href="${url2}" style="text-decoration: underline">Inactive</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <c:forEach var="i" begin="1" end="${sessionScope.NUM_OF_PAGES}">
                            <c:url var="url" value="AdminViewMentor">
                                <c:param name="pageID" value="${i}"/>
                                <c:param name="searchValue" value="${param.searchValue}"/>
                            </c:url>
                            <a href="${url}" style="text-decoration: underline">${i}</a>
                        </c:forEach>
                    </c:if>
                </div>
            </main>
        </div>     
            
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.concat.min.js"></script>
        <script src="js/menu.js"></script>
    </body>
</html>
