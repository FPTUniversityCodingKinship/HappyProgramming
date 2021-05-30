<%-- 
    Document   : mentee_listSuggestion
    Created on : May 30, 2021, 7:33:53 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List mentor suggestion</title>
        <style>
            
        </style>
    </head>
    <body>
        <c:if test="${not empty sessionScope.LIST_REQUEST}">
            Choose request to get mentor suggestion: <br/>
            <c:forEach var="request" items="${sessionScope.LIST_REQUEST}">
                <c:url var="url" value="MenteeShowRequest">
                    <c:param name="action" value="Suggest"/>
                    <c:param name="requestID" value="${request.requestID}"/>
                </c:url>
                <a href="${url}">${request.title}</a>, 
            </c:forEach>
            <br/><br/>
            <c:if test="${not empty sessionScope.REQUEST_INFO}">
                <c:set var="request" value="${sessionScope.REQUEST_INFO}"/>
                <c:set var="skillsName" value="${fn:substring(request.requestID,6,request.requestID.length())}"/>
                Skill(s): ${fn:replace(skillsName, '_', ' and ')}
                is/are selected for ${request.title} <br/>
                <c:if test="${not empty sessionScope.MAPPING_MENTORS_ID}">
                    <c:set var="listMentorsID" value="${sessionScope.MAPPING_MENTORS_ID}"/>
                    Suggested mentor mapping these skills:
                    
                        <c:forEach var="mentorID" items="${listMentorsID}">
                            <c:url var="url" value="ShowMentorDetails">
                                <c:param name="mentorID" value="${mentorID}"/>
                            </c:url>
                            <a href="${url}">${mentorID}</a>, 
                        </c:forEach><br/><br/>
                        <c:if test="${not empty sessionScope.MENTOR_INFO}">
                            <c:set var="mentorInfo" value="${sessionScope.MENTOR_INFO}"/>
                            Full name of mentor: ${fn:split(mentorInfo, ",")[0]}<br/>
                            Account name: ${fn:split(mentorInfo, ",")[1]}<br/>
                            Rating star: ${fn:split(mentorInfo, ",")[2]}<br/>
                            Number of requests this mentor currently has: ${fn:split(mentorInfo, ",")[3]}<br/>
                        </c:if>
                    <form action="MenteeListSuggestion" method="POST">    
                        <c:if test="${not empty sessionScope.CHOSEN_MENTOR_ID}">
                            <input type="hidden" name="chosenRequestID" value="${sessionScope.REQUEST_INFO.requestID}" />
                            <input type="hidden" name="chosenMentorID" value="${sessionScope.CHOSEN_MENTOR_ID}" />
                            <input type="submit" value="Invite" />
                        </c:if>
                    </form>
                </c:if>
                <br/>
            </c:if>
        </c:if>
        <c:if test="${empty sessionScope.LIST_REQUEST}">
            No request yet!<br/>
        </c:if>   
        <a href="MenteeHomePage">Back to homepage</a>   
    </body>
</html>
