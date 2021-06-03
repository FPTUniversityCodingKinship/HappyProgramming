<%-- 
    Document   : admin_updateSkill
    Created on : Jun 3, 2021, 8:05:52 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update skill</title>
    </head>
    <body>
        <c:if test="${not empty sessionScope.LIST_ALL_SKILLS}">
            <c:set var="listSkills" value="${sessionScope.LIST_ALL_SKILLS}"/>
            <form id="form1" action="AdminShowSkillInfo" method="POST">
                <select name="skillName" onchange="document.getElementById('form1').submit();">
                    <option>Choose skill</option>
                    <c:forEach var="skill" items="${listSkills}">
                        <option value="${skill.skillName}">${skill.skillName}</option>
                    </c:forEach>
                </select>
            </form>
            <br/>
            <c:if test="${not empty sessionScope.SKILL_INFO}">
                <form action="AdminUpdateSkill" method="POST">
                    <c:set var="skillInfo" value="${sessionScope.SKILL_INFO}"/>
                    <input type="hidden" name="skillID" value="${skillInfo.skillID}"/>
                    <input type="hidden" name="currentSkillName" value="${skillInfo.skillName}"/>
                    Skill name: <input type="text" name="txtSkillName" value="${skillInfo.skillName}" /> <br/>
                    <c:if test="${not empty requestScope.UPDATE_SKILL_ERROR.skillNameExisted}">
                        <font color="red">${requestScope.UPDATE_SKILL_ERROR.skillNameExisted}</font><br/>
                    </c:if>
                    <c:if test="${not empty requestScope.UPDATE_SKILL_ERROR.skillNameLengthErr}">
                        <font color="red">${requestScope.UPDATE_SKILL_ERROR.skillNameLengthErr}</font><br/>
                    </c:if>
                    Current status: <c:if test="${skillInfo.status eq 'true'}">Active</c:if>
                                    <c:if test="${skillInfo.status eq 'false'}">Inactive</c:if>
                    <br/>
                    Status: <select name="status">
                        <option>Active</option>
                        <option>Inactive</option>
                    </select> <br/>
                    <input type="submit" value="OK" />
                </form>
            </c:if>
        </c:if>
            <a href="AdminHomePage">Back to homepage</a>
    </body>
</html>
