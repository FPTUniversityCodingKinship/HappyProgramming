<%-- 
    Document   : updateCV
    Created on : Jun 5, 2021, 2:59:29 PM
    Author     : Tran Phong <phongntse150974@fpt.edu.vn>
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update your CV</title>      

    </head>
    <body>
        <jsp:useBean id="userDao" class="hps.users.UsersDAO" scope="session"/>
        <c:set var="user" value="${userDao.getProfile(sessionScope.CURRENT_USER.userID)}"
               scope="page"/>
        <header>
            <nav>
                <form action="Login">
                    <input type="hidden" name="txtUsername" value="${user.username}" />
                    <input type="hidden" name="txtPassword" value="${user.password}" />
                    <input type="submit" value="Back" name="btAction"/>
                </form><br/>
            </nav>
        </header>
        <h1>Update your CV</h1>
        <h3>Fill all of the information correctly to update your CV</h3>
        <c:set var="mentor" value="${sessionScope.CURRENT_USER}" />

        <jsp:useBean id="mentorDetailsDAO" scope="page" class="hps.mentorDetails.MentorDetailsDAO"/>
        <c:set var="mentorDetails" value="${mentorDetailsDAO.getMentorDetails(mentor.userID)}"/>

        <jsp:useBean id="mentorSkillsDAO" scope="page" class="hps.mentorSkills.MentorSkillsDAO" />
        <c:set var="mentorSkills" value="${mentorSkillsDAO.getMentorSkills(mentor.userID)}" />

        <c:set var="error" value="${requestScope.UPDATE_CV_ERROR}" />
        <c:if test="${not empty error}">
            <c:if test="${not fn:contains(error, 'Date') }">
                <font color="red">
                ${error}
                </font>
            </c:if>


        </c:if>
        <c:set var="success" value="${requestScope.UPDATE_CV_SUCCESS}" />
        <c:if test="${not empty success}">
            <font color="green">
            ${success}
            </font>
        </c:if>
        <!--<form action="CreateCV" method="POST">-->
        <form id="updateInformation" action="UpdateCV" method="POST" enctype="multipart/form-data">
            <!--UserID-->
            <input type="hidden" name="userID" id="userID" value="${mentor.userID}" />
            <!--Username--> 
            <label for="username">Username: </label>
            <input type="text" name="username" id="username" 
                   value="${mentor.username}" readonly="readonly" />
            <!--<div class="error" id="errUsername"></div>-->
            <br/>
            <!--Avatar-->
            Avatar: <img src="images/${mentor.image}" alt="The mentor's avatar" 
                         style="width:250px"><br />
            Update your avatar here: <input type="file" name="imageFile" id="imageFile" accept="image/*"/><br />
            <!--Full name-->
            <label for="fullname">Full Name: </label>
            <input type="text" name="fullname" id="fullname" 
                   value="<c:if test="${not empty param.fullname}">${param.fullname}</c:if><c:if test="${empty param.fullname}">${mentor.fullname}</c:if>" />
                   <div class="error" id="errFullname"></div>
                   <br/>
                   <!--DOB-->
                   <label for="dob">Date of Birth (dd/mm/yyyy): </label>
                   <input type="date" name="dob" id="dob" 
                          value="<c:if test="${not empty param.dob}">${param.dob}</c:if><c:if test="${empty param.dob}">${mentor.dob}</c:if>" />
                   <!--            <div class="error" id="errDob"></div>-->
                   <br/>
            <c:if test="${not empty error}">
                <c:if test="${fn:contains(error, 'Date') }">
                    <font color="red">
                    ${error}
                    </font>
                </c:if>
            </c:if>
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
                <c:if test="${not empty param.sex}">
                    <option value="M" 
                            <c:if test="${param.sex eq 'M'}">selected="selected"</c:if>
                                >Male</option>
                            <option value="F"
                            <c:if test="${param.sex eq 'F'}">selected="selected"</c:if>
                                >Female</option>
                            <option value="X" 
                            <c:if test="${param.sex eq 'X'}">selected="selected"</c:if>
                                >Undefined</option>
                </c:if>
                <c:if test="${empty param.sex}">
                    <option value="M" 
                            <c:if test="${mentor.sex eq 'M'}">selected="selected"</c:if>
                                >Male</option>
                            <option value="F"
                            <c:if test="${mentor.sex eq 'F'}">selected="selected"</c:if>
                                >Female</option>
                            <option value="X" 
                            <c:if test="${mentor.sex eq 'X'}">selected="selected"</c:if>
                                >Undefined</option>
                </c:if>
            </select>
            <br/>
            <!--Address-->
            <label for="address">Address: </label>
            <textarea name="address" id="address" rows="1" cols="30"><c:if test="${not empty param.address}">${param.address}</c:if><c:if test="${empty param.address}">${mentor.address}</c:if></textarea>
                <div class="error" id="errAddress"></div>
                <br/>
                <!--Facebook-->
                <label for="facebook">Facebook: </label>
                    <input type="text" name="facebook" id="facebook" value="<c:if test="${not empty param.facebook}">${param.facebook}</c:if><c:if test="${empty param.facebook}">${mentorDetails.facebook}</c:if>" placeholder="https://www.facebook.com/abcxyz"/>
                <div class="error" id="errFacebook"></div>
                <br/>
                <!--Github-->
                <label for="github">Github: </label>
                    <input type="text" name="github" id="github" value="<c:if test="${not empty param.github}">${param.github}</c:if><c:if test="${empty param.github}">${mentorDetails.github}</c:if>" placeholder="https://www.github.com/abcxyz" />
                <div class="error" id="errGithub"></div>
                <br/>
                <!--Language-->
                <label for="language">Language: </label>
                    <input type="text" name="language" id="language" value="<c:if test="${not empty param.language}">${param.language}</c:if><c:if test="${empty param.language}">${mentorDetails.language}</c:if>" placeholder="Vietnamese, English,..."/>
                <div class="error" id="errLanguage"></div>
                <br/>
                <!--Profession-->
                <label for="profession">Profession: </label>
                    <textarea name="profession" id="profession" rows="3" cols="20" placeholder="Your major profession"><c:if test="${not empty param.profession}">${param.profession}</c:if><c:if test="${empty param.profession}">${mentorDetails.profession}</c:if></textarea>
                <div class="error" id="errProfession"></div>
                <br/>
                <!--Profession Description-->
                <label for="proDescription">Profession Description: </label>
                    <textarea class="editor" name="proDescription" id="proDescription" rows="5" cols="20" placeholder="Description about your major profession"><c:if test="${not empty param.proDescription}">${param.proDescription}</c:if><c:if test="${empty param.proDescription}">${mentorDetails.introduction}</c:if></textarea>
                <div class="error" id="errProDescription"></div>
                <br/>
                <!--Skills-->
                Skills:
            <jsp:useBean id="skillsDAO" scope="page" class="hps.skills.SkillsDAO" />
            <c:set var="skillsList" value="${skillsDAO.loadSkills()}" />
            <c:set var="countSkill" scope="page" value="" />
            <div id="skills">
                <c:forEach items="${mentorSkills}" var="mentorSkill" varStatus="count">
                    <c:set var="countSkill" value="${count.count}" />
                    <div id="skill${count.count}">
                        <select name="skill${count.count}" data-filled="skillsList">
                            <c:forEach items="${skillsList}" var="skillItem" varStatus="iCount">
                                <option value="${skillItem.skillID}" <c:if test="${skillItem.skillID eq mentorSkill.skillID}">selected=""</c:if>>${skillItem.skillName}</option>
                            </c:forEach>
                        </select>
                        <label for="years${count.count}">Years Of Experience: </label>
                        <input type="number" min="0" name="years${count.count}" id="years${count.count}" value="${mentorSkill.yearsExperience}" />
                        <label for="rate${count.count}">Level of this skill (1-5): </label>
                        <input type="number" min="1" max="5" name="rate${count.count}" id="rate${count.count}" value="${mentorSkill.rate}" />
                        <div class="error" id="errSkill${count.count}"></div>
                    </div>
                    <br/>
                </c:forEach>

                <br/><input type="button" id="btnAddSkill" value="Add more Skill"></input>
            </div>
            <input type="hidden" name="numSkills" id="numSkills" value="${countSkill}" />
            <br/>
            <!--Service Description-->
            <label for="serDescription">Service Description: </label>
            <textarea class="editor" name="serDescription" id="serDescription" rows="5" cols="20" placeholder="Description about the service you provide"><c:if test="${not empty param.serDescription}">${param.serDescription}</c:if><c:if test="${empty param.serDescription}">${mentorDetails.serviceDescription}</c:if></textarea>
                <div class="error" id="errSerDescription"></div>
                <br/>
                <!--Achievement Description-->
                <label for="achDescription">Achievement Description: </label>
                    <textarea class="editor" name="achDescription" id="achDescription" rows="5" cols="20" placeholder="Description about the achievements you have achieved"><c:if test="${not empty param.achDescription}">${param.achDescription}</c:if><c:if test="${empty param.achDescription}">${mentorDetails.achievementDescription}</c:if></textarea>
            <div class="error" id="errAchDescription"></div>
            <br/>
            <!--button-->
            <input id="btnCreate" type="button" value="OK" name="btnAction" />
            <input type="reset" value="Reset" />

            <div class="noti" id="noti"></div>

        </form>

        <!--Script-->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="https://cdn.tiny.cloud/1/uvrwnlarfgzt2bb56y6vdl6cb5mhfr6h5sl6tqnucb5yuvvu/tinymce/5/tinymce.min.js" referrerpolicy="origin"></script>
        <script src="mentor/js/updateCV.js"></script>
    </body>
</html>
