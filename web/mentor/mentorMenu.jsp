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
        <div class="row">
            <div class="col-6">
                <img src="images/main-logo.png" class="w-100" />
            </div>
        </div>
        <h3>Happy Programming</h3>
    </div>

    <ul class="list-unstyled components"> 
        <li class="<c:if test="${iPage eq ''}">${"active"}</c:if>">
                <a href="UpdateProfilePage">View Profile</a>
            </li>
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
    </ul>
</nav>
