<%-- 
    Document   : admin_viewSkills
    Created on : Jun 7, 2021, 8:39:58 PM
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

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.css">
        <title>View Skills List</title>
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
                    <jsp:param name="page" value="skillsList"/>
                </jsp:include>
            </header>
            <main>
                <div id="content">
                    <jsp:include flush="true" page="/topMenu.jsp"/>
                    <h1 class='mb-3'>View the list of all Skills in the System</h1>
                    <div class="row">
                        <div class="col-8">
                            <c:set var="error" value="${VIEW_SKILLS_LIST_ERROR}" />
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger mt-2" role="alert">
                                ${error}
                                </div>
                            </c:if>
                            
                            <c:set var="data" value="${ALL_SKILLS_LIST}" />
                            <c:if test="${not empty data}">
                                <div class='row'>
                                    <div class='col-5 offset-7'>
                                        <a class='btn btn-primary mb-2 float-right' href="AdminCreateSkillPage">Add a new Skill</a>
                                    </div>
                                </div>
                                

                                <c:set var="statusError" value="${SKILL_UPDATE_STATUS_ERROR}"/>
                                <c:if test="${not empty statusError}">
                                    <div class="alert alert-danger mt-2" role="alert">
                                    ${statusError}
                                    </div>
                                </c:if>
                                <c:set var="statusSuccess" value="${SKILL_UPDATE_STATUS_SUCCESS}"/>
                                <c:if test="${not empty statusSuccess}">
                                    <div class="alert alert-success mt-2" role="alert">
                                    ${statusSuccess}
                                    </div>
                                </c:if>

                                <c:set var="nameError" value="${SKILL_UPDATE_NAME_ERROR}"/>
                                <c:if test="${not empty nameError}">
                                    <div class="alert alert-danger mt-2" role="alert">
                                    ${nameError}
                                    </div>
                                </c:if>
                                <c:set var="nameSuccess" value="${SKILL_UPDATE_NAME_SUCCESS}"/>
                                <c:if test="${not empty nameSuccess}">
                                    <div class="alert alert-success mt-2" role="alert">
                                    ${nameSuccess}
                                    </div>
                                </c:if>

                                <table class='table table-bordered table-hover'>
                                    <thead class='thead-light'>
                                        <tr>
                                            <th class="align-middle" scope='col'>No.</th>
                                            <th class="align-middle" scope='col'>ID</th>
                                            <th class="align-middle" scope='col'>Name</th>
                                            <th class="align-middle" scope='col'>Status</th>
                                            <th class="align-middle" scope='col'>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${data}" var="skill" varStatus="count">
                                        <form action="AdminViewSkillsUpdateName">
                                            <tr>
                                                <td class="align-middle" scope='row'>
                                                    ${count.count}
                                                </td>
                                                <td class="align-middle">
                                                    ${skill.skillID}
                                                    <input type="hidden" name="skillID" value="${skill.skillID}" />
                                                </td>
                                                <td class="align-middle">
                                                    <div class="form-group row">
                                                        <input class="form-control ml-3 mr-3 mt-2" type="text" name="skillName" value="${skill.skillName}" />
                                                    </div>
                                                    
                                                    <input type="hidden" name="currentSkillName" value="${skill.skillName}" />
                                                </td>
                                                <td class="align-middle">
                                                    <c:if test="${skill.status eq true}">
                                                        <span class="badge badge-success p-2">Active</span>
                                                    </c:if>
                                                    <c:if test="${skill.status eq false}">
                                                        <span class="badge badge-danger p-2">Inactive</span>
                                                    </c:if>
                                                </td>
                                                <td class="align-middle">
                                                    <c:if test="${skill.status eq true}">
                                                        <c:url var="inactive" value="AdminViewSkillsUpdateStatus">
                                                            <c:param name="skillID" value="${skill.skillID}"/>
                                                            <c:param name="updatedStatus" value="inactive"/>
                                                        </c:url>
                                                        <a class='btn btn-outline-danger' href="${inactive}">Deactivate Skill</a>
                                                    </c:if>
                                                    <c:if test="${skill.status eq false}">
                                                        <c:url var="active" value="AdminViewSkillsUpdateStatus">
                                                            <c:param name="skillID" value="${skill.skillID}"/>
                                                            <c:param name="updatedStatus" value="active"/>
                                                        </c:url>
                                                        <a class='btn btn-outline-success ml-2' href="${active}">Activate Skill</a>
                                                    </c:if>
                                                    <input class='btn btn-info' type="submit" name="btnUpdate" value="Update Skill Name"/>
                                                </td>
                                            </tr>
                                        </form>
                                    </c:forEach>
                                    </tbody>
                                </table>

                            </c:if>
                        </div>
                    </div>
                </div>
            </main>
        </div>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.concat.min.js"></script>
        <script src="js/menu.js"></script>
    </body>
</html>
