<%-- 
    Document   : admin_viewRequestDetail
    Created on : Jun 9, 2021, 8:59:07 PM
    Author     : Tran Phong <phongntse150974@fpt.edu.vn>
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="x-ua-compatible" content="ie=edge">

        <link rel="stylesheet" href="css/bootstrap/bootstrap.min.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.css">
        <title>View Request Detail</title>
    </head>
    <body>
        <div class="wrapper">
            <c:set var="user" value="${sessionScope.CURRENT_USER}" scope="page"/>
            <c:if test="${empty user}">
                <c:redirect url="LoginPage" />
            </c:if>
            <c:if test="${not fn:startsWith(user.userID, 'AD')}">
                <c:redirect url="/" />
            </c:if>
            <header>
                <!--Menu-->
                <jsp:include flush="true" page="adminMenu.jsp">
                    <jsp:param name="page" value="requestDetail"/>
                </jsp:include>
            </header>
            <main>
                <div id="content">
                    <jsp:include flush="true" page="/topMenu.jsp"/>
                    <h1>View Detail of a Request</h1>
                    <div class="row">
                        <div class="col-8">
                            <c:set var="error" value="${VIEW_REQUEST_ERROR}"/>
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger mt-2" role="alert">
                                    ${error}
                                </div>
                            </c:if>
                            <c:set var="data" value="${REQUEST_INFO}"/>
                            <c:set var="skillsName" value="${SKILLS_NAME}"/>
                            <c:if test="${not empty data and not empty skillsName}">
                                <h3 class='mt-3'>Details for request ${data.requestID}</h3>

                                <table class='table'>
                                    <tbody>
                                        <tr>
                                            <th scope='row'>Title</th>
                                            <td>${data.title}</td>
                                        </tr>
                                        <tr>
                                            <th scope='row'>Deadline date</th>
                                            <td>${(fn:split(data.deadline," "))[0]}</td>
                                        </tr>
                                        <tr>
                                            <th scope='row'>Deadline hour</th>
                                            <td>${(fn:split(data.deadline,' '))[1]}</td>
                                        </tr>
                                        <tr>
                                            <th scope='row'>Request content</th>
                                            <td>${data.reqContent}</td>
                                        </tr>
                                        <tr>
                                            <th scope='row'>Skills</th>
                                            <td>${skillsName}</td>
                                        </tr>
                                        <tr>
                                            <th scope='row'>Status</th>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${data.status eq 'P'}">Pending</c:when>
                                                    <c:when test="${data.status eq 'A'}">Accepted</c:when>
                                                    <c:when test="${data.status eq 'R'}">Rejected</c:when>
                                                    <c:when test="${data.status eq 'C'}">Closed</c:when>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </c:if>
                        </div>
                    </div>
                </div>
            </main>
        </div>
        <script src = "js/jquery/jquery-3.6.0.min.js"></script>
        <script src = "js/popper/popper.min.js"></script>
        <script src = "js/bootstrap/bootstrap.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.concat.min.js"></script>
        <script src="js/menu.js"></script>
    </body>
</html>
