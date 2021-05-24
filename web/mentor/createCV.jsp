<%-- 
    Document   : createCV
    Created on : May 24, 2021, 9:54:25 AM
    Author     : Tran Phong <phongntse150974@fpt.edu.vn>
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create your CV</title>
    </head>
    <body>
        <h1>Create your CV</h1>
        <h3>Fill all of the information correctly to create your CV</h3>
        <c:set var="mentor" value="${sessionScope.CURRENT_USER}" />
        <form action="CreateCV" method="POST">
            <!--Username--> 
            <label for="username">Username: </label>
            <input type="text" name="username" id="username" 
                   value="${mentor.username}" readonly="readonly" />
            <br/>
            <!--Full name-->
            <label for="fullname">Full Name: </label>
            <input type="text" name="fullname" id="fullname" 
                   value="${mentor.fullname}" />
            <br/>
            <!--DOB-->
            <label for="dob">Date of Birth: </label>
            <input type="date" name="dob" id="dob" 
                   value="${mentor.dob}" />
            <br/>
            <!--Email-->
            <label for="email">Email: </label>
            <input type="email" name="email" id="email" 
                   value="${mentor.email}" />
            <br/>
            <!--Sex-->
            <label for="sex">Sex: </label>
            <select name="sex" id="sex">
                <option value="M" 
                    <c:if test="${mentor.sex eq 'M'}">selected="selected"</c:if>
                >Male</option>
                <option value="F"
                    <c:if test="${mentor.sex eq 'F'}">selected="selected"</c:if>
                >Female</option>
                <option value="X" 
                    <c:if test="${mentor.sex eq 'M'}">selected="selected"</c:if>
                >Undefined</option>
            </select>
            <br/>
            <!--Address-->
            <label for="address">Address: </label>
            <textarea name="address" id="address" rows="4" cols="20">${mentor.address}</textarea>
            <!--Profession-->
            <label for="profession">Profession: </label>
            
            

        </form>
    </body>
</html>
