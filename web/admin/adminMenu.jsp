<%-- 
    Document   : adminMenu
    Created on : Jun 21, 2021, 8:33:03 PM
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
                <img src="images/favicon.ico" class="w-100" />
            </div>
        </div>
        <h3>Happy Programming</h3>
    </div>

    <ul class="list-unstyled components"> 
        <li class="<c:if test="${iPage eq ''}">${"active"}</c:if>">
                <a href="UpdateProfilePage">View Profile</a>
            </li>
            <li class="<c:if test="${iPage eq 'requestsList' or iPage eq 'requestDetail'}">${"active"}</c:if>">
                <a href="AdminViewRequestsList">Requests List</a>
            </li>
            <li class="<c:if test="${iPage eq 'menteeStatistics'}">${"active"}</c:if>">
                <a href="AdminMenteeStatistics">Mentees Statistics</a>
            </li>
            <li class="<c:if test="${iPage eq 'skillsList'}">${"active"}</c:if>">
                <a href="AdminViewSkillsList">Skills List</a>
            </li>
            <li class="<c:if test="${iPage eq 'viewAllMentor'}">${"active"}</c:if>">
                <a href="AdminViewMentor">View list of all mentor</a>
            </li>
            <li class="<c:if test="${iPage eq 'createSkill'}">${"active"}</c:if>">
                <a href="AdminCreateSkillPage">Create skill</a>
            </li>
            <li class="<c:if test="${iPage eq 'updateSkill'}">${"active"}</c:if>">
            <a href="AdminLoadSkills">Update skill</a>
        </li>

    </ul>
</nav>

