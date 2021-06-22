<%-- 
    Document   : mentee_followMentor
    Created on : Jun 22, 2021, 6:50:47 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Follow mentor</title>
    </head>
    <body>
        <header>
            <nav>
                <form action="Login">
                    <input type="hidden" name="txtUsername" value="${user.username}" />
                    <input type="hidden" name="txtPassword" value="${user.password}" />
                    <input type="submit" value="Back" name="btAction"/>
                </form><br/>
            </nav>
        </header>
        <c:if test="${not empty sessionScope.MENTOR_LIST}">
            <c:set var="mentorList" value="${sessionScope.MENTOR_LIST}"/>
            <c:set var="professionList" value="${sessionScope.PROFESSION_LIST}"/>
            <c:set var="followedMentors" value="${sessionScope.FOLLOWED_MENTORS}"/>
            <table border="1">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Full name</th>
                        <th>Account name</th>
                        <th>Profession</th>
                        <th>Follow</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="mentor" items="${mentorList}" varStatus="counter">
                        <tr>
                            <td>
                                ${counter.count}
                            </td>
                            <td>
                                ${mentor.fullname}
                            </td>
                            <td>
                                ${mentor.username}
                            </td>
                            <td>
                                <c:forEach var="profession" items="${professionList}">
                                    <c:if test="${mentor.userID eq profession['key']}">
                                        ${profession['value']}
                                    </c:if>
                                </c:forEach>
                            </td>
                            <td>
                                
                                <c:if test="${fn:contains(followedMentors, mentor.userID)}">
                                    Followed    
                                </c:if>
                                <c:if test="${not fn:contains(followedMentors, mentor.userID)}">
                                    <c:url var="url" value="MenteeCreateFollow">
                                        <c:param name="menteeID" value="${sessionScope.CURRENT_USER.userID}"/>
                                        <c:param name="mentorID" value="${mentor.userID}"/>
                                    </c:url>
                                    <a href="${url}">Follow</a>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

        </c:if>
    </body>
</html>
