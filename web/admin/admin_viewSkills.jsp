<%-- 
    Document   : admin_viewSkills
    Created on : Jun 7, 2021, 8:39:58 PM
    Author     : Tran Phong <phongntse150974@fpt.edu.vn>
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Skills List</title>
    </head>
    <body>
        <h1>View the list of all Skills in the System</h1>
        <!--STT, 
        ID, 
        Name of skill, 
        status (link or button) allow to enable/disable skill, 
        link (or button) allow to update skill. 
        The + button to allow go to create skill to add new skill.-->

        <c:set var="error" value="${VIEW_SKILLS_LIST_ERROR}" />
        <c:if test="${not empty error}">
            <font color="red">
            ${error}
            </font>
        </c:if>
        <c:set var="data" value="${ALL_SKILLS_LIST}" />
        <c:if test="${not empty data}">
            <a href="AdminCreateSkillPage">Add a new Skill</a><br/>

            <c:set var="statusError" value="${SKILL_UPDATE_STATUS_ERROR}"/>
            <c:if test="${not empty statusError}">
                <font color="red">
                ${statusError}
                </font>
            </c:if>
            <c:set var="statusSuccess" value="${SKILL_UPDATE_STATUS_SUCCESS}"/>
            <c:if test="${not empty statusSuccess}">
                <font color="green">
                ${statusSuccess}
                </font>
            </c:if>

            <c:set var="nameError" value="${SKILL_UPDATE_NAME_ERROR}"/>
            <c:if test="${not empty nameError}">
                <font color="red">
                ${nameError}
                </font>
            </c:if>
            <c:set var="nameSuccess" value="${SKILL_UPDATE_NAME_SUCCESS}"/>
            <c:if test="${not empty nameSuccess}">
                <font color="green">
                ${nameSuccess}
                </font>
            </c:if>

            <table border="1">
                <thead>
                    <tr>
                        <th>No.</th>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${data}" var="skill" varStatus="count">
                    <form action="AdminViewSkillsUpdateName">
                        <tr>
                            <td>
                                ${count.count}
                            </td>
                            <td>
                                ${skill.skillID}
                                <input type="hidden" name="skillID" value="${skill.skillID}" />
                            </td>
                            <td>
                                <input type="text" name="skillName" value="${skill.skillName}" />
                                <input type="hidden" name="currentSkillName" value="${skill.skillName}" />
                            </td>
                            <td>
                                <c:if test="${skill.status eq true}">
                                    <font color="green">Active</font>
                                </c:if>
                                <c:if test="${skill.status eq false}">
                                    <font color="red">Inactive</font>
                                </c:if>
                            </td>
                            <td>
                                <c:if test="${skill.status eq true}">
                                    <c:url var="inactive" value="AdminViewSkillsUpdateStatus">
                                        <c:param name="skillID" value="${skill.skillID}"/>
                                        <c:param name="updatedStatus" value="inactive"/>
                                    </c:url>
                                    <a href="${inactive}">Inactivate Skill</a>
                                </c:if>
                                <c:if test="${skill.status eq false}">
                                    <c:url var="active" value="AdminViewSkillsUpdateStatus">
                                        <c:param name="skillID" value="${skill.skillID}"/>
                                        <c:param name="updatedStatus" value="active"/>
                                    </c:url>
                                    <a href="${active}">Activate Skill</a>
                                </c:if>
                                <input type="submit" name="btnUpdate" value="Update Skill Name"/>
                            </td>
                        </tr>
                    </form>
                </c:forEach>
            </tbody>
        </table>

    </c:if>
</body>
</html>
