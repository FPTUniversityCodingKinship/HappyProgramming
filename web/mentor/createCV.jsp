<%-- 
    Document   : createCV
    Created on : May 24, 2021, 9:54:25 AM
    Author     : Tran Phong <phongntse150974@fpt.edu.vn>
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create your CV</title>      

    </head>
    <body>
        <jsp:useBean id="userDao" class="hps.users.UsersDAO" scope="session"/>
        <c:set var="user" value="${userDao.getProfile(sessionScope.CURRENT_USER.userID)}"
               scope="page"/>
        <c:if test="${empty user}">
            <c:redirect url="LoginPage" />
        </c:if>
        <c:if test="${not fn:startsWith(user.userID, 'MT')}">
            <c:redirect url="/" />
        </c:if>
        <header>
            <nav>
                <form action="Login">
                    <input type="hidden" name="txtUsername" value="${user.username}" />
                    <input type="hidden" name="txtPassword" value="${user.password}" />
                    <input type="submit" value="Back" name="btAction"/>
                </form><br/>
            </nav>
        </header>
    </form>
    <h1>Create your CV</h1>
    <jsp:useBean id="mentorDetailsDAO" scope="page" class="hps.mentorDetails.MentorDetailsDAO"/>
    <c:set var="mentorDetails" value="${mentorDetailsDAO.getMentorDetails(user.userID)}" />
    <c:if test="${not empty mentorDetails}">
        <h3>
            Your CV had been created! If you want to update it, <a href="UpdateCVPage">click here</a>
        </h3>
    </c:if>
    <c:if test="${empty mentorDetails}">


        <h3>Fill all of the information correctly to create your CV</h3>
        <c:set var="mentor" value="${sessionScope.CURRENT_USER}" />
        <!--<form action="CreateCV" method="POST">-->
        <form>
            <!--UserID-->
            <input type="hidden" name="userID" id="userID" value="${mentor.userID}" />
            <!--Username--> 
            <label for="username">Username: </label>
            <input type="text" name="username" id="username" 
                   value="${mentor.username}" readonly="readonly" />
            <!--<div class="error" id="errUsername"></div>-->
            <br/>
            <!--Full name-->
            <label for="fullname">Full Name: </label>
            <input type="text" name="fullname" id="fullname" 
                   value="${mentor.fullname}" />
            <div class="error" id="errFullname"></div>
            <br/>
            <!--DOB-->
            <label for="dob">Date of Birth (dd/mm/yyyy): </label>
            <input type="date" name="dob" id="dob" 
                   value="${mentor.dob}" />
            <div class="error" id="errDob"></div>
            <br/>
            <!--Email-->
            <label for="email">Email: </label>
            <input readonly="" type="email" name="email" id="email" 
                   value="${mentor.email}" />
            <div class="error" id="errEmail"></div>
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
                        <c:if test="${mentor.sex eq 'X'}">selected="selected"</c:if>
                            >Undefined</option>
                </select>
                <br/>
                <!--Address-->
                <label for="address">Address: </label>
                <textarea name="address" id="address" rows="1" cols="30">${mentor.address}</textarea>
            <div class="error" id="errAddress"></div>
            <br/>
            <!--Facebook-->
            <label for="facebook">Facebook: </label>
            <input type="text" name="facebook" id="facebook" value="" placeholder="https://www.facebook.com/abcxyz"/>
            <div class="error" id="errFacebook"></div>
            <br/>
            <!--Github-->
            <label for="github">Github: </label>
            <input type="text" name="github" id="github" value="" placeholder="https://www.github.com/abcxyz" />
            <div class="error" id="errGithub"></div>
            <br/>
            <!--Language-->
            <label for="language">Language: </label>
            <input type="text" name="language" id="language" value="" placeholder="Vietnamese, English,..."/>
            <div class="error" id="errLanguage"></div>
            <br/>
            <!--Profession-->
            <label for="profession">Profession: </label>
            <textarea name="profession" id="profession" rows="3" cols="20" placeholder="Your major profession"></textarea>
            <div class="error" id="errProfession"></div>
            <br/>
            <!--Profession Description-->
            <label for="proDescription">Profession Description: </label>
            <textarea class="editor" name="proDescription" id="proDescription" rows="5" cols="20" placeholder="Description about your major profession"></textarea>
            <div class="error" id="errProDescription"></div>
            <br/>
            <!--Skills-->
            Skills:
            <div id="skills">
                <div id="skill1">
                    <select name="skill1" data-filled="skillsList">

                    </select>
                    <label for="years1">Years Of Experience: </label>
                    <input type="number" min="0" name="years1" id="years1" value="1" />
                    <label for="rate1">Level of this skill (1-5): </label>
                    <input type="number" min="1" max="5" name="rate1" id="rate1" value="1" />
                    <input type="button" style="display: none" id='btnRemoveSkill1' onclick="removeSkill(1)" value="Remove Skills" /><br/>
                    <div class="error" id="errSkillYears1"></div>
                    <div class="error" id="errSkillRate1"></div>
                </div>
                <br/>
                <div id="break"></div><input type="button" id="btnAddSkill" value="Add more Skill"></input>
            </div>
            <input type="hidden" name="numSkills" id="numSkills" value="1" />
            <br/>
            <!--Service Description-->
            <label for="serDescription">Service Description: </label>
            <textarea class="editor" name="serDescription" id="serDescription" rows="5" cols="20" placeholder="Description about the service you provide"></textarea>
            <div class="error" id="errSerDescription"></div>
            <br/>
            <!--Achievement Description-->
            <label for="achDescription">Achievement Description: </label>
            <textarea class="editor" name="achDescription" id="achDescription" rows="5" cols="20" placeholder="Description about the achievements you have achieved"></textarea>
            <div class="error" id="errAchDescription"></div>
            <br/>
            <!--button-->
            <input id="btnCreate" type="button" value="OK" name="btnAction" />
            <input type="reset" value="Reset" />

            <div class="noti" id="noti"></div>

        </form>
    </c:if>
    <!--Script-->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
    <script src="https://cdn.tiny.cloud/1/uvrwnlarfgzt2bb56y6vdl6cb5mhfr6h5sl6tqnucb5yuvvu/tinymce/5/tinymce.min.js" referrerpolicy="origin"></script>
    <script src="mentor/js/createCV.js"></script>
</body>
</html>
