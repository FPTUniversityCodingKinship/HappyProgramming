<%-- 
    Document   : mentee_updateRequest
    Created on : May 27, 2021, 3:03:47 PM
    Author     : ADMIN
--%>

<%@page import="hps.skills.SkillsDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update request</title>
    </head>
    <body>
        <c:if test="${not empty requestScope.LIST_REQUEST}">
            Choose request for updating: <br/>
            <c:forEach var="request" items="${requestScope.LIST_REQUEST}">
                <c:url var="url" value="MenteeShowRequest">
                    <c:param name="requestID" value="${request.requestID}"/>
                </c:url>
                <a href="${url}">${request.title}</a>
                (Status: ${request.status})<br/> 
            </c:forEach>
            <br/><br/>    
                
            <c:if test="${not empty sessionScope.REQUEST_INFO}">
                <c:set var="request" value="${sessionScope.REQUEST_INFO}"/>
                <form action="MenteeUpdateRequestSeparately" method="POST">
                    <c:set var="error" value="${requestScope.UPDATE_REQUEST_ERROR}"/>
                    Title: <input type="text" name="title" value="${request.title}"><br/>
                    <c:if test="${not empty error.titleLengthError}" >
                        <font color="red">${error.titleLengthError}</font><br/>
                    </c:if>
                    Deadline date (year-month-day): <input type="text" name="deadlineDate" 
                                    value="${fn:split(request.deadline," ")[0]}" /><br/>
                    <c:if test="${not empty error.deadlineDateError}" >
                        <font color="red">${error.deadlineDateError}</font><br/>
                    </c:if>
                    <c:set var="hour" value="${fn:split(request.deadline,' ')[1]}"/>
                    Deadline hour (hour:minute): <input type="text" name="deadlineHour" 
                            value="${fn:substring(hour,0,5)}" /><br/>
                    <c:if test="${not empty error.deadlineTimeError}" >
                        <font color="red">${error.deadlineTimeError}</font><br/>
                    </c:if>
                    Content: <br/> <textarea name="reqContent" rows="4" cols="30"></textarea><br/>
                    <c:if test="${not empty error.contentLengthError}" >
                        <font color="red">${error.contentLengthError}</font><br/>
                    </c:if>
                    Select skill (1-3): <br/>
                    <%
                        ArrayList<SkillsDTO> skillList = (ArrayList)hps.skills.SkillsDAO.loadSkills();
                        for(SkillsDTO skill : skillList){
                            %>
                    <input type="checkbox" name="ckb" value="<%= skill.getSkillName() %>" 
                           onclick="return chkControl()"/><%= skill.getSkillName() %><br/>
                    <%
                        }
                    %>
                    <c:if test="${not empty error.ckbError}" >
                        <font color="red">${error.ckbError}</font><br/>
                    </c:if>
                    Your mentor ID: <input type="text" name="mentorID" value="${request.mentorID}" /><br/>
                    <c:if test="${not empty error.mentorIDConflictError}" >
                        <font color="red">${error.mentorIDConflictError}</font><br/>
                    </c:if>

                    <input type="submit" value="Update" name="btnAction" onclick="valCkb()"/>
                </form>
            </c:if>
        </c:if>
        <c:if test="${empty requestScope.LIST_REQUEST}">
            No request yet!
        </c:if>
        <a href="MenteeHomePage">Back to homepage</a>    
        <script>
            function chkControl() {
                var a = document.getElementsByName("ckb");
                var total = 0;
                var count;
                for (count = 0; count < a.length; count++) {
                    if (a[count].checked == true) {
                        total = total + 1;
                    }
                }
                if (total > 3 || total < 1) {
                    alert("Select at least 1, at most 3");
                    return false;
                }
            }
            function valCkb()
            {
                var checkboxs = document.getElementsByName("ckb");
                var iCheck = false;
                for (var i = 0; i < checkboxs.length; i++)
                {
                    if (checkboxs[i].checked)
                    {
                        iCheck = true;
                        break;
                    }
                }
                if (iCheck){
                    
                }else
                    alert("Please select at least 1 skill");
            }
        </script>
    </body>
</html>
