<%-- 
    Document   : menteeMenu
    Created on : Jun 23, 2021, 1:15:02 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>

<c:set var="iPage" value="${param.page}" />

<!-- Sidebar -->
<nav id="sidebar">
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
            <li class="<c:if test="${iPage eq 'createRequest'}">${"active"}</c:if>">
                <a href="MenteeCreateRequestPage">Create request</a>
            </li>
            <li class="<c:if test="${iPage eq 'listRequest'}">${"active"}</c:if>">
                <a href="MenteeListRequest">List my requests</a>
            </li>
            <li class="<c:if test="${iPage eq 'statisticRequest'}">${"active"}</c:if>">
                <a href="MenteeStatisticRequest">Statistic of requests</a>
            </li>
            <li class="<c:if test="${iPage eq 'updateRequest'}">${"active"}</c:if>">
                <a href="MenteeLoadRequest?action=Update">Update a request</a>
            </li>
            <li class="<c:if test="${iPage eq 'rate'}">${"active"}</c:if>">
                <a href="MenteeRate">Rate & Comment on a mentor</a>
            </li>
            <li class="<c:if test="${iPage eq 'listSuggestion'}">${"active"}</c:if>">
                <a href="MenteeLoadRequest?action=Suggest">List suggested Mentors</a>
            </li>
            <li class="<c:if test="${iPage eq 'followMentor'}">${"active"}</c:if>">
            <a href="MenteeFollowMentor">Follow a mentor</a><br/>
        </li>
    </ul>
</nav>
