<%-- 
    Document   : topMenu
    Created on : Jun 21, 2021, 7:42:10 PM
    Author     : Tran Phong <phongntse150974@fpt.edu.vn>
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<c:set var="mentor" value="${sessionScope.CURRENT_USER}" />
<jsp:useBean id="mentorDetailsDAO" scope="page" class="hps.mentorDetails.MentorDetailsDAO" />
<c:set var="mentorCV" value="${mentorDetailsDAO.getMentorDetails(mentor.userID)}" />

<nav id="topMenu" class="navbar fixed-top navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
        <c:if test="${not empty param.back}">
            <a class='btn btn-outline-primary' href='${param.back}'>Back</a>
        </c:if>
        
        <ul class="nav navbar-nav ml-auto">
            <li class="nav-item ml-3">
                <a class="nav-link" href="#">Welcome, ${mentor.fullname}</a>
            </li>
            <li class="nav-item ml-3">
                <a class="nav-link btn btn-outline-danger" href="Logout">LOG OUT</a>
            </li>
        </ul>
    </div>
</nav>