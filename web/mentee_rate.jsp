<%-- 
    Document   : mentee_rate
    Created on : May 28, 2021, 9:37:37 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Rate & Comment mentor</title>
    </head>
    <body>
        <c:if test="${not empty sessionScope.REQ_INFO_FOR_RATING}">
            Select the concluded request you want to rate:<br/>
            <c:set var="reqInfo" value="${sessionScope.REQ_INFO_FOR_RATING}"/>
            <c:forEach var="entry" items="${reqInfo}">
                <c:url var="url" value="MenteeRate">
                    <c:param name="requestID" value="${entry.key}"/>
                    <c:param name="mentorID" value="${fn:split(entry.value,',')[1]}"/>
                </c:url>
                <a href="${url}">${fn:split(entry.value,',')[0]}</a><br/>
            </c:forEach>
                <br/>
            <c:if test="${not empty sessionScope.RATING_INFO}">
                <c:set var="info" value="${sessionScope.RATING_INFO}"/>
                <c:forEach var="entry" items="${reqInfo}">
                    <c:if test="${entry.key == info[0]}">
                        Title of this request: ${fn:split(entry.value,',')[0]}<br/>
                    </c:if>
                </c:forEach>
                <form action="MenteeRate" method="POST">
                    <c:set var="error" value="${requestScope.RATE_ERROR}"/>
                    <input type="hidden" name="requestID" value="${info[0]}"/>
                    <input type="hidden" name="menteeID" value="${info[1]}"/>
                    <input type="hidden" name="mentorID" value="${info[2]}"/>
                    Rate: <input type="text" name="rate" value="${param.rate}" /><br/>
                    <c:if test="${not empty error.rateOutOfBoundError}" >
                        <font color="red">${error.rateOutOfBoundError}</font><br/>
                    </c:if>
                    Comment:<br/> <textarea name="comments" rows="4" cols="30"></textarea><br/>
                    <c:if test="${not empty error.commentLengthError}" >
                        <font color="red">${error.commentLengthError}</font><br/>
                    </c:if>
                    <input type="submit" value="OK" /><br/>
                    <c:if test="${not empty error.ratedError}" >
                        <font color="red">${error.ratedError}</font><br/>
                    </c:if>
                </form>
            </c:if>
        </c:if>
        <c:if test="${empty sessionScope.REQ_INFO_FOR_RATING}">
            No request yet for rating!<br/>
        </c:if>
        <br/>
        
        <a href="MenteeHomePage">Back to homepage</a>
    </body>
</html>
