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
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="x-ua-compatible" content="ie=edge">

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.css">
        <link rel="stylesheet" href="css/style.css">
        <title>Create your CV</title>      

    </head>
    <body>
        <div class="wrapper">
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
                <!--Menu-->
                <jsp:include flush="true" page="mentorMenu.jsp">
                    <jsp:param name="page" value="updateCV"/>
                </jsp:include>
            </header>
            <main>
                <div id="content">
                    <jsp:include flush="true" page="/topMenu.jsp"/>
                    <h1>Create your CV</h1>
                    <div class="row">
                        <div class="col-8">
                            <jsp:useBean id="mentorDetailsDAO" scope="page" class="hps.mentorDetails.MentorDetailsDAO"/>
                            <c:set var="mentorDetails" value="${mentorDetailsDAO.getMentorDetails(user.userID)}" />

                            <c:if test="${not empty mentorDetails}">
                                <h3>
                                    Your CV had been created! If you want to update it, <a class="btn btn-outline-info" href="UpdateCVPage">click here</a>
                                </h3>
                            </c:if>

                            <c:if test="${empty mentorDetails}">
                                <h3>Fill all of the information correctly to create your CV</h3>

                                <c:set var="mentor" value="${sessionScope.CURRENT_USER}" />
                                <form>
                                    <!--UserID-->
                                    <input type="hidden" name="userID" id="userID" value="${mentor.userID}" />

                                    <!--Username--> 
                                    <div class="form-group row">
                                        <label for="username" class="col-4 col-form-label">Username</label>
                                        <div class="col-5">
                                            <input type="text" class="form-control" name="username" id="username" 
                                                   value="${mentor.username}" readonly="readonly" />
                                        </div>
                                    </div>

                                    <!--Full name-->
                                    <div class="form-group row">
                                        <label for="fullname" class="col-4 col-form-label">Full Name</label>
                                        <div class="col-5">
                                            <input type="text" class="form-control" name="fullname" id="fullname" 
                                                   value="${mentor.fullname}" 
                                                   />
                                            <div class="error alert alert-danger d-none mt-2" role="alert" id="errFullname"></div>
                                        </div>
                                    </div>

                                    <!--DOB-->
                                    <div class="form-group row">
                                        <label for="dob" class="col-4 col-form-label">Date of Birth (dd/mm/yyyy)</label>
                                        <div class="col-5">
                                            <input type="date" class="form-control" name="dob" id="dob" 
                                                   value="${mentor.dob}" 
                                                   />
                                            <div class="error alert alert-danger d-none mt-2" role="alert" id="errDob"></div>
                                        </div>
                                    </div>

                                    <!--Email-->
                                    <div class="form-group row">
                                        <label for="email" class="col-4 col-form-label">Email</label>
                                        <div class="col-5">
                                            <input type="email" class="form-control" name="email" id="email" readonly="" 
                                                   value="${mentor.email}" />
                                            <div class="error alert alert-danger d-none mt-2" role="alert" id="errEmail"></div>
                                        </div>
                                    </div>

                                    <!--Sex-->
                                    <div class="form-group row">
                                        <label for="sex" class="col-4 col-form-label">Sex</label>
                                        <div class="col-5">
                                            <select name="sex" id="sex" class="form-control">
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
                                            </div>
                                        </div>

                                        <!--Address-->
                                        <div class="form-group row">
                                            <label for="address" class="col-4 col-form-label">Address</label>
                                            <div class="col-8">
                                                <textarea class="form-control" name="address" id="address" rows="3">${mentor.address}</textarea>
                                            <div class="error alert alert-danger d-none mt-2" role="alert" id="errAddress"></div>
                                        </div>
                                    </div>

                                    <!--Facebook-->
                                    <div class="form-group row">
                                        <label for="facebook" class="col-4 col-form-label">Facebook</label>
                                        <div class="col-8">
                                            <input class="form-control" type="text" name="facebook" id="facebook" 
                                                   value="" placeholder="https://www.facebook.com/abcxyz"/>
                                            <div class="error alert alert-danger d-none mt-2" role="alert" id="errFacebook"></div>
                                        </div>
                                    </div>

                                    <!--Github-->
                                    <div class="form-group row">
                                        <label for="github" class="col-4 col-form-label">Github</label>
                                        <div class="col-8">
                                            <input class="form-control" type="text" name="github" id="github" 
                                                   value="" placeholder="https://www.github.com/abcxyz" />
                                            <div class="error alert alert-danger d-none mt-2" role="alert" id="errGithub"></div>
                                        </div>
                                    </div>

                                    <!--Language-->
                                    <div class="form-group row">
                                        <label for="language" class="col-4 col-form-label">Language</label>
                                        <div class="col-8">
                                            <input class="form-control" type="text" name="language" id="language" 
                                                   value="" placeholder="Vietnamese, English,..."/>
                                            <div class="error alert alert-danger d-none mt-2" role="alert" id="errLanguage"></div>
                                        </div>
                                    </div>

                                    <!--Profession-->
                                    <div class="form-group row">
                                        <label for="profession" class="col-4 col-form-label">Profession</label>
                                        <div class="col-8">
                                            <input class="form-control" name="profession" id="profession" 
                                                   placeholder="Your major profession" value="" />
                                            <div class="error alert alert-danger d-none mt-2" role="alert" id="errProfession"></div>
                                        </div>
                                    </div>

                                    <!--Profession Description-->
                                    <div class="form-group">
                                        <label for="proDescription">Profession Description</label>
                                        <textarea class="editor form-control" name="proDescription" id="proDescription" 
                                                  rows="5" cols="20" 
                                                  placeholder="Description about your major profession"></textarea>
                                        <div class="error alert alert-danger d-none mt-2" role="alert" id="errProDescription"></div>
                                    </div>

                                    <!--Skills-->
                                    <div class="form-group row">
                                        <label for="skills" class="col-2 col-form-label">Skills</label>
                                        <div class="col-10">
                                            <div id="skills">
                                                
                                                <div class="d-none" id="skill0">
                                                    <div class="form-group row">
                                                        <div class="col-2">
                                                            <select class='form-control' name="skill0" data-filled="skillsList">

                                                            </select>
                                                        </div>
                                                        <label class="col-3 col-form-label float-right" for="years0">Years Of Experience: </label>
                                                        <div class="col-2">
                                                            <input class="form-control" type="number" min="0" name="years0" id="years0" value="1" />
                                                        </div>
                                                        <label class="col-3 col-form-label" for="rate0">Level of this skill (1-5): </label>
                                                        <div class="col-2">
                                                            <input class="form-control" type="number" min="1" max="5" name="rate0" id="rate0" value="1" />
                                                        </div>
                                                    </div>
                                                     <input  class="btn btn-outline-danger mt-0 mb-4 d-none" type="button" id='btnRemoveSkill0' onclick="removeSkill(0)" value="Remove Skill" />
                                                        <div class="error alert alert-danger d-none mt-2" role="alert" id="errSkillYears0"></div>
                                                        <div class="error alert alert-danger d-none mt-2" role="alert" id="errSkillRate0"></div>
                                                </div>
                                                
                                                <div id="skill1">
                                                    <div class="form-group row">
                                                        <div class="col-2">
                                                            <select class='form-control' name="skill1" data-filled="skillsList">

                                                            </select>
                                                        </div>
                                                        <label class="col-3 col-form-label float-right" for="years1">Years Of Experience: </label>
                                                        <div class="col-2">
                                                            <input class="form-control" type="number" min="0" name="years1" id="years1" value="1" />
                                                        </div>
                                                        <label class="col-3 col-form-label" for="rate1">Level of this skill (1-5): </label>
                                                        <div class="col-2">
                                                            <input class="form-control" type="number" min="1" max="5" name="rate1" id="rate1" value="1" />
                                                        </div>
                                                    </div>
                                                     <input  class="btn btn-outline-danger mt-0 mb-4 d-none" type="button" id='btnRemoveSkill1' onclick="removeSkill(1)" value="Remove Skill" />
                                                        <div class="error alert alert-danger d-none mt-2" role="alert" id="errSkillYears1"></div>
                                                        <div class="error alert alert-danger d-none mt-2" role="alert" id="errSkillRate1"></div>
                                                </div>
                                                <input class="btn btn-info d-block mt-3" type="button" id="btnAddSkill" value="Add more Skill"></input>
                                                <input type="hidden" name="numSkills" id="numSkills" value="1" />
                                            </div>
                                        </div>
                                    </div>

                                    <!--Service Description-->
                                    <div class="form-group">
                                        <label for="serDescription">Service Description</label>
                                        <textarea class="editor form-control" name="serDescription" id="serDescription" 
                                                  rows="5" cols="20" placeholder="Description about the service you provide"></textarea>
                                        <div class="error alert alert-danger d-none mt-2" role="alert" id="errSerDescription"></div>
                                    </div>

                                    <!--Achievement Description-->
                                    <div class="form-group">
                                        <label for="achDescription">Achievement Description</label>
                                        <textarea class="editor form-control" name="achDescription" id="achDescription" 
                                                  rows="5" cols="20" placeholder="Description about the achievements you have achieved"></textarea>
                                        <div class="error alert alert-danger d-none mt-2" role="alert" id="errAchDescription"></div>
                                    </div>

                                    <!--button-->
                                    <input class="btn btn-primary" id="btnCreate" type="button" value="Create your CV" name="btnAction" />
                                    <input class="btn btn-secondary" type="reset" value="Reset" />

                                    <div class="alert d-none mt-2" role="alert" id="noti">
                                        
                                    </div>

                                </form>
                            </c:if>
                        </div>

                        <div class="col-4">

                        </div>
                    </div>
                </div>
            </main>
        </div>
        <!--Script-->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
        <script src="https://cdn.tiny.cloud/1/uvrwnlarfgzt2bb56y6vdl6cb5mhfr6h5sl6tqnucb5yuvvu/tinymce/5/tinymce.min.js" referrerpolicy="origin"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.concat.min.js"></script>
        <script src="js/menu.js"></script>
        <script src="mentor/js/createCV.js"></script>
    </body>
</html>
