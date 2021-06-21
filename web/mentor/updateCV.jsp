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
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="x-ua-compatible" content="ie=edge">

        <link rel="stylesheet" href="css/bootstrap/bootstrap.min.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.css">
        <title>Update your CV</title>      

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
                    <h1>Update your CV</h1>
                    <div class="row">
                        <div class="col-8">
                            <jsp:useBean id="mentorDetailsDAO" scope="page" class="hps.mentorDetails.MentorDetailsDAO"/>
                            <c:set var="mentorDetails" value="${mentorDetailsDAO.getMentorDetails(user.userID)}" />

                            <c:if test="${empty mentorDetails}">
                                <h3>
                                    Your CV had not been created! <a class="btn btn-outline-info" href="CreateCVPage">Click here</a> to create your CV!
                                </h3>
                            </c:if>
                            
                            <c:if test="${not empty mentorDetails}">
                            
                                <h3>Fill all of the information correctly to update your CV</h3>
                                <c:set var="mentor" value="${sessionScope.CURRENT_USER}" />

                                <jsp:useBean id="mentorSkillsDAO" scope="page" class="hps.mentorSkills.MentorSkillsDAO" />
                                <c:set var="mentorSkills" value="${mentorSkillsDAO.getMentorSkills(mentor.userID)}" />

                                <c:set var="error" value="${requestScope.UPDATE_CV_ERROR}" />


                                <c:set var="success" value="${requestScope.UPDATE_CV_SUCCESS}" />
                                <c:if test="${not empty success}">
                                    <div class="alert alert-success mt-2 mb-2" role="alert">
                                        ${success}
                                    </div>
                                </c:if>

                                <form id="updateInformation" action="UpdateCV" method="POST" enctype="multipart/form-data">
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

                                    <!--Avatar-->
                                    <div class="form-group">
                                        <div class="row">
                                            <label for="userImage" class="col-4 col-form-label">Avatar</label>
                                            <div class="col-5">
                                                <img id="userImage" src="images/${mentor.image}" alt="The mentor's avatar" 
                                                     class="img-thumbnail">
                                            </div>
                                        </div>
                                        <div class="row mt-2">
                                            <label for="imageFile" class="col-4 col-form-label">Update your avatar here</label>
                                            <div class="col-5">
                                                <input type="file" class="form-control" name="imageFile" id="imageFile" accept="image/*"/>
                                                <div class="error alert alert-danger d-none mt-2" role="alert" id="errAvatar"></div>
                                            </div>
                                        </div>
                                    </div>

                                    <!--Full name-->
                                    <div class="form-group row">
                                        <label for="fullname" class="col-4 col-form-label">Full Name</label>
                                        <div class="col-5">
                                            <input type="text" class="form-control" name="fullname" id="fullname" 
                                                   value="<c:if test="${not empty param.fullname}">${param.fullname}</c:if><c:if test="${empty param.fullname}">${mentor.fullname}</c:if>" 
                                            />
                                            <div class="error alert alert-danger d-none mt-2" role="alert" id="errFullname"></div>
                                        </div>
                                    </div>'

                                    <!--DOB-->
                                    <div class="form-group row">
                                        <label for="dob" class="col-4 col-form-label">Date of Birth (dd/mm/yyyy)</label>
                                        <div class="col-5">
                                            <input type="date" class="form-control" name="dob" id="dob" 
                                                   value="<c:if test="${not empty param.dob}">${param.dob}</c:if><c:if test="${empty param.dob}">${mentor.dob}</c:if>" 
                                                />
                                        <div class="error alert alert-danger d-none mt-2" role="alert" id="errDob">
                                            <c:if test="${not empty error}">
                                                <c:if test="${not fn:contains(error, 'Date') }">
                                                    ${error}
                                                </c:if>
                                            </c:if>
                                        </div>
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
                                        </div>
                                    </div>

                                    <!--Address-->
                                    <div class="form-group row">
                                        <label for="address" class="col-4 col-form-label">Address</label>
                                        <div class="col-8">
                                            <textarea class="form-control" name="address" id="address" rows="3"><c:if test="${not empty param.address}">${param.address}</c:if><c:if test="${empty param.address}">${mentor.address}</c:if></textarea>
                                            <div class="error alert alert-danger d-none mt-2" role="alert" id="errAddress"></div>
                                        </div>
                                    </div>

                                    <!--Facebook-->
                                    <div class="form-group row">
                                        <label for="facebook" class="col-4 col-form-label">Facebook</label>
                                        <div class="col-8">
                                            <input class="form-control" type="text" name="facebook" id="facebook" 
                                                   value="<c:if test="${not empty param.facebook}">${param.facebook}</c:if><c:if test="${empty param.facebook}">${mentorDetails.facebook}</c:if>" 
                                                placeholder="https://www.facebook.com/abcxyz"/>
                                            <div class="error alert alert-danger d-none mt-2" role="alert" id="errFacebook"></div>
                                        </div>
                                    </div>

                                    <!--Github-->
                                    <div class="form-group row">
                                        <label for="github" class="col-4 col-form-label">Github</label>
                                        <div class="col-8">
                                            <input class="form-control" type="text" name="github" id="github" 
                                                   value="<c:if test="${not empty param.github}">${param.github}</c:if><c:if test="${empty param.github}">${mentorDetails.github}</c:if>" 
                                                placeholder="https://www.github.com/abcxyz" />
                                            <div class="error alert alert-danger d-none mt-2" role="alert" id="errGithub"></div>
                                        </div>
                                    </div>

                                    <!--Language-->
                                    <div class="form-group row">
                                        <label for="language" class="col-4 col-form-label">Language</label>
                                        <div class="col-8">
                                            <input class="form-control" type="text" name="language" id="language" 
                                                   value="<c:if test="${not empty param.language}">${param.language}</c:if><c:if test="${empty param.language}">${mentorDetails.language}</c:if>" 
                                                placeholder="Vietnamese, English,..."/>
                                            <div class="error alert alert-danger d-none mt-2" role="alert" id="errLanguage"></div>
                                        </div>
                                    </div>

                                    <!--Profession-->
                                    <div class="form-group row">
                                        <label for="profession" class="col-4 col-form-label">Profession</label>
                                        <div class="col-8">
                                            <input class="form-control" name="profession" id="profession" 
                                                   placeholder="Your major profession" 
                                                       value="<c:if test="${not empty param.profession}">${param.profession}</c:if><c:if test="${empty param.profession}">${mentorDetails.profession}</c:if>" />
                                            <div class="error alert alert-danger d-none mt-2" role="alert" id="errProfession"></div>
                                        </div>
                                    </div>

                                    <!--Profession Description-->
                                    <div class="form-group">
                                        <label for="proDescription">Profession Description</label>
                                        <textarea class="editor form-control" name="proDescription" id="proDescription" 
                                                  rows="5" cols="20" 
                                                      placeholder="Description about your major profession"><c:if test="${not empty param.proDescription}">${param.proDescription}</c:if><c:if test="${empty param.proDescription}">${mentorDetails.introduction}</c:if></textarea>
                                        <div class="error alert alert-danger d-none mt-2" role="alert" id="errProDescription"></div>
                                    </div>

                                    <!--Skills-->
                                    <div class="form-group row">
                                        <label for="skills" class="col-2 col-form-label">Skills</label>
                                        <div class="col-10">
                                        <jsp:useBean id="skillsDAO" scope="page" class="hps.skills.SkillsDAO" />
                                        <c:set var="skillsList" value="${skillsDAO.loadSkills()}" />
                                        <c:set var="countSkill" scope="page" value="" />
                                        <div id="skills">

                                            <div class="d-none" id="skill0">
                                                <div class="form-group row">
                                                    <div class="col-2">
                                                        <select class="form-control" name="skill0" data-filled="skillsList">
                                                            <c:forEach items="${skillsList}" var="skillItem" varStatus="iCount">
                                                                <option value="${skillItem.skillID}" <c:if test="${skillItem.skillID eq mentorSkill.skillID}">selected=""</c:if>>${skillItem.skillName}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                    <label class="col-3 col-form-label float-right" for="years0">Years Of Experience</label>
                                                    <div class="col-2">
                                                        <input class="form-control" type="number" min="0" name="years0" id="years0" value="1" />
                                                    </div>
                                                    <label class="col-3 col-form-label" for="rate0">Level of this skill (1-5)</label>
                                                    <div class="col-2">
                                                        <input class="form-control" type="number" min="1" max="5" name="rate0" id="rate0" value="1" /> 
                                                    </div>
                                                </div>
                                                <input class="btn btn-outline-danger mt-0 mb-4" type="button" id='btnRemoveSkill0' onclick="removeSkill(0)" value="Remove Skill" />
                                                    <div class="error alert alert-danger d-none mt-2" role="alert" id="errSkillYears0"></div>
                                                    <div class="error alert alert-danger d-none mt-2" role="alert" id="errSkillRate0"></div>
                                            </div>

                                            <c:forEach items="${mentorSkills}" var="mentorSkill" varStatus="count">
                                                <c:set var="countSkill" value="${count.count}" />
                                                <div id="skill${count.count}">
                                                    <div class="form-group row">
                                                        <div class="col-2">
                                                            <select class="form-control" name="skill${count.count}" data-filled="skillsList">
                                                                <c:forEach items="${skillsList}" var="skillItem" varStatus="iCount">
                                                                    <option value="${skillItem.skillID}" <c:if test="${skillItem.skillID eq mentorSkill.skillID}">selected=""</c:if>>${skillItem.skillName}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                        <label class="col-3 col-form-label float-right" for="years${count.count}">Years Of Experience</label>
                                                        <div class="col-2">
                                                            <input class="form-control" type="number" min="0" name="years${count.count}" id="years${count.count}" value="${mentorSkill.yearsExperience}" />
                                                        </div>
                                                        <label class="col-3 col-form-label" for="rate${count.count}">Level of this skill (1-5)</label>
                                                        <div class="col-2">
                                                            <input class="form-control" type="number" min="1" max="5" name="rate${count.count}" id="rate${count.count}" value="${mentorSkill.rate}" /> 
                                                        </div>
                                                    </div>
                                                    <input class="btn btn-outline-danger mt-0 mb-4" type="button" <c:if test="${count.count eq 1}">style="display: none"</c:if>id='btnRemoveSkill${count.count}' onclick="removeSkill(${count.count})" value="Remove Skill" />
                                                    <div class="error alert alert-danger d-none mt-2" role="alert" id="errSkillYears${count.count}"></div>
                                                    <div class="error alert alert-danger d-none mt-2" role="alert" id="errSkillRate${count.count}"></div>
                                                </div>

                                            </c:forEach>
                                            <input class="btn btn-info d-block mt-3" type="button" id="btnAddSkill" value="Add more Skill"></input>
                                        </div>
                                    </div>
                                </div>
                                <input type="hidden" name="numSkills" id="numSkills" value="<c:if test="${countSkill >= 1}">${countSkill}</c:if><c:if test="${countSkill < 1}">0</c:if>" />

                                <!--Service Description-->
                                <div class="form-group">
                                    <label for="serDescription">Service Description</label>
                                    <textarea class="editor form-control" name="serDescription" id="serDescription" 
                                              rows="5" cols="20" placeholder="Description about the service you provide"
                                                  ><c:if test="${not empty param.serDescription}">${param.serDescription}</c:if><c:if test="${empty param.serDescription}">${mentorDetails.serviceDescription}</c:if></textarea>
                                    <div class="error alert alert-danger d-none mt-2" role="alert" id="errSerDescription"></div>
                                </div>

                                <!--Achievement Description-->

                                <div class="form-group">
                                    <label for="achDescription">Achievement Description</label>
                                    <textarea class="editor form-control" name="achDescription" id="achDescription" 
                                              rows="5" cols="20" placeholder="Description about the achievements you have achieved"
                                                  ><c:if test="${not empty param.achDescription}">${param.achDescription}</c:if><c:if test="${empty param.achDescription}">${mentorDetails.achievementDescription}</c:if></textarea>
                                    <div class="error alert alert-danger d-none mt-2" role="alert" id="errAchDescription"></div>
                                </div>

                                <!--button-->
                                <input class="btn btn-primary" id="btnUpdate" type="button" value="Update CV" name="btnAction" />
                                <input class="btn btn-secondary" type="reset" value="Reset" />
                                <div class="alert alert-success d-none noti mt-2" role="alert" id="noti"></div>
                            </form>
                            </div>
                            <div class="col-4">

                            </div>
                        </c:if>
                    </div>

                </div>
            </main>
        </div>

        <!--Script-->
        <script src = "js/jquery/jquery-3.6.0.min.js"></script>
        <script src = "js/popper/popper.min.js"></script>
        <script src = "js/bootstrap/bootstrap.min.js"></script>
        <script src="https://cdn.tiny.cloud/1/uvrwnlarfgzt2bb56y6vdl6cb5mhfr6h5sl6tqnucb5yuvvu/tinymce/5/tinymce.min.js" referrerpolicy="origin"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.concat.min.js"></script>
        <script src="js/menu.js"></script>
        <script src="mentor/js/updateCV.js"></script>
    </body>
</html>
