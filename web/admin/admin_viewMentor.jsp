<%-- 
    Document   : admin_viewMentor
    Created on : May 31, 2021, 3:49:03 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View all mentor</title>
    </head>
    <body>
        <form action="AdminViewMentor" method="POST">
            <input type="text" name="searchValue" value="${param.searchValue}" />
            <input type="submit" value="Search" /><br/>
        </form>
            
        <c:if test="${not empty sessionScope.MENTOR_INFO}">
            <c:set var="listMentorInfo" value="${sessionScope.MENTOR_INFO}"/>
            <table border="1">
                <thead>
                    <tr>
                        <th>STT</th>
                        <th>ID</th>
                        <th>Full name</th>
                        <th>Account name</th>
                        <th>Profession</th>
                        <th># Accepted requests</th>
                        <th>Percentage completed (%)</th>
                        <th>Rate star</th>
                        <th>Status</th>
                        <th>Active/Inactive</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="mentorInfo" items="${listMentorInfo}" varStatus="counter">
                        <tr>
                            <td>
                                ${counter.count}
                            </td>
                            <td>
                                ${mentorInfo['key']}
                            </td>
                            <td>
                                ${fn:split(mentorInfo['value'],',')[0]}
                            </td>
                            <td>
                                ${fn:split(mentorInfo['value'],',')[1]}
                            </td>
                            <td>
                                ${fn:split(mentorInfo['value'],',')[2]}
                            </td>
                            <td>
                                ${fn:split(mentorInfo['value'],',')[3]}
                            </td>
                            <td>
                                ${fn:split(mentorInfo['value'],',')[4]}
                            </td>
                            <td>
                                ${fn:split(mentorInfo['value'],',')[5]}
                            </td>
                            <td>  
                                <c:if test="${fn:split(mentorInfo['value'],',')[6] eq '1'}">Active</c:if>
                                <c:if test="${fn:split(mentorInfo['value'],',')[6] eq '0'}">Inactive</c:if>
                            </td>
                            <td>
                                <c:url var="url1" value="AdminManageMentorStatus">
                                    <c:param name="searchValue" value="${param.searchValue}"/>
                                    <c:param name="mentorID" value="${mentorInfo['key']}"/>
                                    <c:param name="status" value="1"/>
                                </c:url>
                                <a href="${url1}">Active</a> /
                                <c:url var="url2" value="AdminManageMentorStatus">
                                    <c:param name="searchValue" value="${param.searchValue}"/>
                                    <c:param name="mentorID" value="${mentorInfo['key']}"/>
                                    <c:param name="status" value="0"/>
                                </c:url>
                                <a href="${url2}">Inactive</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <c:forEach var="i" begin="1" end="${sessionScope.NUM_OF_PAGES}">
                <c:url var="url" value="AdminViewMentor">
                    <c:param name="pageID" value="${i}"/>
                    <c:param name="searchValue" value="${param.searchValue}"/>
                </c:url>
                <a href="${url}">${i}</a>
            </c:forEach>
        </c:if>
            
        <br/>
        <a href="AdminHomePage">Back to homepage</a>
    </body>
</html>
