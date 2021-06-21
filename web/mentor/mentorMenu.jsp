<%-- 
    Document   : mentorMenu
    Created on : Jun 19, 2021, 9:01:21 PM
    Author     : Tran Phong <phongntse150974@fpt.edu.vn>
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<c:set var="iPage" value="${param.page}" />

<c:set var="mentor" value="${sessionScope.CURRENT_USER}" />
<jsp:useBean id="mentorDetailsDAO" scope="page" class="hps.mentorDetails.MentorDetailsDAO" />
<c:set var="mentorCV" value="${mentorDetailsDAO.getMentorDetails(mentor.userID)}" />

<!-- Sidebar -->
<nav id="sidebar">
    <!--    <div class="sidebar-header">
            <h3>Bootstrap Sidebar</h3>
        </div>-->
    <div class="sidebar-header">
        <h3>Happy Programming</h3>
        <p class="mt-3">
            Welcome, ${mentor.fullname}
        </p>
    </div>

    <ul class="list-unstyled components"> 
        <li class="<c:if test="${iPage eq 'viewFollowing' or iPage eq 'viewInvited'}">${"active"}</c:if>">
            <a class="dropdown-toggle" href="#viewRequestSubMenu" id="navbarDropdown" 
               data-toggle="collapse" aria-expanded="false">
                    View Requests
                </a>
            <ul class="collapse list-unstyled" id="viewRequestSubMenu">
                <li>
                    <a class="<c:if test="${iPage eq 'viewFollowing'}">${"active"}</c:if>" href="FollowingRequest">From your Followers</a>
                </li>
                <li>
                    <a class="<c:if test="${iPage eq 'viewInvited'}">${"active"}</c:if>" href="InvitingRequest">From who invited you</a>
                </li>
            </ul>
        </li>

        <c:if test="${empty mentorCV}">
            <!--Create CV-->
            <li class="<c:if test="${iPage eq 'createCV'}">${"active"}</c:if>">
                <a href="CreateCVPage">Create your CV</a>
            </li>
        </c:if>
        <c:if test="${not empty mentorCV}">
            <!--Update CV-->
            <li class="<c:if test="${iPage eq 'updateCV'}">${"active"}</c:if>">
                <a href="UpdateCVPage">Update your CV</a>
            </li>
        </c:if>

        <li class="<c:if test="${iPage eq 'requestStats'}">${"active"}</c:if>">
            <a href="RequestsStatistics">Your Requests Statistics</a>
        </li>
        
        <li>
            <a href="Logout">LOG OUT</a>
        </li>
    </ul>
</nav>

<!--    <nav class="navbar navbar-expand-lg navbar-dark fixed-top">
        <div class="navbar-brand col-5 col-md-2 col-lg-2">
            <span style="font-weight:800">Happy Programming</span>
        </div>

        <button class="navbar-toggler btn-warning bttn-material-circle bttn-md bttn-no-outline pt-1" type="button" data-toggle="collapse" data-target="#navbarToggler" aria-controls="navbarToggler" aria-expanded="false" aria-label="Toggle navigation">
            <i class="fas fa-bars"></i>
        </button>

        <div class="collapse navbar-collapse" id="navbarToggler">
            <ul class="navbar-nav mr-auto"> 
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle <c:if test="${iPage eq 'viewFollowing' or iPage eq 'viewInvited'}">${"active"}</c:if>" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        View Requests
                    </a>
                    <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <a class="dropdown-item <c:if test="${iPage eq 'viewFollowing'}">${"active"}</c:if>" href="FollowingRequest">From your Followers</a>
                    <a class="dropdown-item <c:if test="${iPage eq 'viewInvited'}">${"active"}</c:if>" href="InvitingRequest">From who invited you</a>
                    </div>
                </li>

            <c:if test="${empty mentorCV}">
                Create CV
                <li class="nav-item ml-3 <c:if test="${iPage eq 'createCV'}">${"active"}</c:if>">
                        <a class="nav-link" href="CreateCVPage">Create your CV</a>
                    </li>
            </c:if>
            <c:if test="${not empty mentorCV}">
                Update CV
                <li class="nav-item ml-3 <c:if test="${iPage eq 'updateCV'}">${"active"}</c:if>">
                        <a class="nav-link" href="UpdateCVPage">Update your CV</a>
                    </li>
            </c:if>

            <li class="nav-item ml-3 <c:if test="${iPage eq 'requestStats'}">${"active"}</c:if>">
                <a class="nav-link" href="RequestsStatistics">Your Requests Statistics</a>
            </li>
        </ul>
    </div>
</nav>-->
