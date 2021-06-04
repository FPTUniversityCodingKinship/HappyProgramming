<%-- 
    Document   : admin_createSkill
    Created on : Jun 2, 2021, 7:53:14 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create skill</title>
    </head>
    <body>
        <form action="AdminCreateSkill" method="POST">
            Skill name: <input type="text" name="skillName" value="${param.skillName}" /><br/>
            <c:if test="${not empty requestScope.SKILL_NAME_ERROR.skillNameExisted}">
                <font color="red">${requestScope.SKILL_NAME_ERROR.skillNameExisted}</font><br/>
            </c:if>
            <c:if test="${not empty requestScope.SKILL_NAME_ERROR.skillNameLengthErr}">
                <font color="red">${requestScope.SKILL_NAME_ERROR.skillNameLengthErr}</font><br/>
            </c:if>
                It is a: <input type="radio" name="skillType" value="PL" required="required"/>
                    <label for="PL">Programming Language</label>
                    <input type="radio" name="skillType" value="FW" />
                    <label for="PL">Framework</label><br/>
            <input type="submit" value="OK" onclick="valRadio()"/>
        </form>
        <a href="AdminHomePage">Back to homepage</a>
    </body>
</html>
