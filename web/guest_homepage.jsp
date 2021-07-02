<%-- 
    Document   : guest_homepage
    Created on : Jun 1, 2021, 5:06:06 PM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Happy Programming System</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link rel="stylesheet" href="css/general.css">
        <link rel="stylesheet" href="css/guest_homepage.css">
        <!-- Source for animated background -->
        <link rel="stylesheet" href="css/animated-background.css">
        <!-- External ref -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script type="module"  src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js"></script>
        <jsp:useBean id="comDAO" class="hps.comments.CommentsDAO" scope="request"/>
        <jsp:useBean id="usersDAO" class="hps.users.UsersDAO" scope="request"/>
        <jsp:useBean id="mentorSkillsDAO" class="hps.mentorSkills.MentorSkillsDAO" scope="request"/>
        <jsp:useBean id="skillsDAO" class="hps.skills.SkillsDAO" scope="request"/>

    </head>
    <body>

        <div class="header">
            <a href="LoginPage">Login</a>
            <a href="SignUpPage">Sign Up</a>
        </div>

        <!-- Background -->
        <div class="animated-background">
            <canvas id="background">Node Garden</canvas>
            <script src="js/animated-background.js"></script>
        </div>
        <div class="row fade-in ml-2" style="margin-top: 20%">
            <div class="col col-md-6">
                <h1 class="text-warning" style="transition: .3s">Greetings!</h1>
                <h2 class="text-light">Who we are: </h2>
                <hr>
                <p class="text-light">
                    A group of young, aspiring, and dedicated individuals seeking
                    to harbour a haven to nourish the talents of the like-minded.
                </p>
                <p class="text-light">
                    We wholly dedicate ourselves to the quest of providing servitude
                    to whoever in needs, and thus endeavour to achieve the ultimate goal of
                    humanity's betterment as a whole.
                </p>
                <form action="LoginPage">
                    <input type="button" class="btn btn-success" value="Let Us Unite">
                </form>
            </div>
            <div class="col col-md-3">
                <img src="images/template.jpg" alt="About us Image">
            </div>
        </div>

        <div class="row fade-in ml-2" style="margin-top: 20%;">
            <div class="col col-md-3">
                <img class="" src="images/pinnacle.jpg" alt="Top Image" 
                     style="width: 120%; height: auto">
            </div>
            <div class="col col-md-7">
                <div class="text-right">
                    <p class="text-light lead strong" 
                       style="font-family: requiem; font-size: 2em">
                        Cum scientia et dedication, 
                        nos de servitute voverint reddent
                    </p>
                    <hr >
                    <h1 class="text-warning" style="transition: .3s">Meet Our Ingenious Minds!</h1>
                    <h2 class="text-light">
                        <a href="#mentorsList">
                            Meet the team 
                        </a>
                    </h2>
                    <hr>
                    <p class="text-light">
                        We recruit only individuals who possess the essence of humanity's wisdom.
                    </p>
                    <p class="text-light">
                        Those who wield the pinnacles of the technological realm.
                    </p>
                    <p class="text-light">
                        Masters of the most abstruse Algorithms.
                    </p>
                    <p class="text-light">
                        Creators of unchained data.
                    </p>
                    <form action="LoginPage">
                        <input type="button" class="btn btn-dark" 
                               value="Join us, let yourself be known">
                    </form>
                </div>
            </div>    
        </div>


        <div class="fade-in" id="mentorsList" style="margin-top: 20%;">
            <h1 class="text-warning test-right">Some of our best</h1>
            <table border="1" class="text-middle">
                <thead>
                    <tr class="text-light">
                        <th class="col-md-2">Avatar</th>
                        <th>Mentor's Name</th>
                        <th>Skills</th>
                    </tr>
                </thead>
                <tbody class="text-light text-middle">
                    <c:forEach var="mentor" items="${comDAO.bestMentor}">
                        <c:set var="dto" value="${usersDAO.getProfile(mentor)}" />
                        <tr>
                            <td>
                                <img src='./images/${mentor}.jpg'
                                     style="width: 100%; height: auto"/>
                            </td>
                            <td>
                                ${dto.fullname}
                            </td>
                            <td>
                                <ul>
                                    <c:forEach var="skill" 
                                               items="${mentorSkillsDAO.getMentorSkills(mentor)}">
                                        <li>
                                            <c:set var="skillId" value="${skill.skillID}"/>
                                            ${skillsDAO.getSkillsName(skillId)}
                                        </li>
                                    </c:forEach>
                                </ul>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <!--            <div class="row fade-in ml-2" style="margin-top: 20%;">
                            <div class="col col-md-3">
                                <img class="" src="images/pinnacle.jpg" alt="Top Image" 
                                     style="width: 120%; height: auto">
                            </div>
            
                            <div class="col col-md-7">
                                <div class="text-right">
                                    <p class="text-light lead strong" 
                                       style="font-family: requiem; font-size: 2em">
                                        Cum scientia et dedication, 
                                        nos de servitute voverint reddent
                                    </p>
                                    <hr >
                                    <h1 class="text-warning" style="transition: .3s">Meet Our Ingenious Minds!</h1>
                                    <h2 class="text-light">Meet the team </h2>
                                    <hr>
                                    <p class="text-light">
                                        We recruit only individuals who possess the essence of humanity's wisdom.
                                    </p>
                                    <p class="text-light">
                                        Those who wield the pinnacles of the technological realm.
                                    </p>
                                    <p class="text-light">
                                        Masters of the most abstruse Algorithms.
                                    </p>
                                    <p class="text-light">
                                        Creators of unchained data.
                                    </p>
                                    <form action="LoginPage">
                                        <input type="button" class="btn btn-dark" value="Join us, let yourself be known">
                                    </form>
                                </div>
                            </div>    
                        </div>-->
        </div>
        <script>
            $(window).on("load", function () {
                $(".fade-in").css("opacity", 0);
                $(window).scroll(function () {
                    var windowBottom = $(this).scrollTop() + $(this).innerHeight();
                    $(".fade-in").each(function () {
                        /* Check the location the element */
                        var objectBottom = $(this).offset().top + $(this).outerHeight();
                        if (Math.abs(windowBottom - objectBottom) <= $(window).height() / 3) {
                            if ($(this).css("opacity") == 0) {
                                $(this).fadeTo(300, 1);
                            }
                        } else {
                            if ($(this).css("opacity") == 1) {
                                $(this).fadeTo(100, 0);
                            }
                        }
                    });
                }).scroll(); //invoke scroll-handler on page-load
            }
            );
        </script>

        <%--
        <script>
            var href = window.location.href;
            var mainURL = href.substring(0, href.indexOf(href.split("/")[4]));
        </script>
        --%>
    </body>
</html>
