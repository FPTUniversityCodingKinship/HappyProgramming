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
        <link rel="icon" href="images/favicon.ico">
        <!-- External stylesheet -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

        <link rel="stylesheet" href="css/general.css">
        <link rel="stylesheet" href="css/guest_homepage.css">
        <link rel="stylesheet" href="css/header.css">
        <!-- Source for animated background -->
        <link rel="stylesheet" href="css/animated-background.css">
        <!-- External script -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script type="module"  src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js"></script>

        <jsp:useBean id="comDAO" class="hps.comments.CommentsDAO" scope="request"/>
        <jsp:useBean id="usersDAO" class="hps.users.UsersDAO" scope="request"/>
        <jsp:useBean id="mentorSkillsDAO" class="hps.mentorSkills.MentorSkillsDAO" scope="request"/>
        <jsp:useBean id="skillsDAO" class="hps.skills.SkillsDAO" scope="request"/>
    </head>
    <body>
        <!-- Header -->
        <nav class="navbar navbar-light w-100">
            <div class="navbar-brand">
                <a class="animated-logo" href="">
                    <img src="images/main-logo.png" alt=""
                         style="width: 64px; float: left; margin: -12px 12px 0 0;"/>
                </a>
                <form class="form-inline input-group"
                      style="width: 320px; float: left; margin-left: 12px">
                    <input class="form-control" type="search" action="#"
                           placeholder="Search something..." aria-label="Search">
                    <div class="input-group-append">
                        <button class="btn btn-success" type="submit">Search</button>
                    </div>
                </form>
            </div>
            <div class="bold-text text-right" id="headerLink">
                <a class="nav-link header-button" href="LoginPage">Log In</a>
                <a class="nav-link header-button" href="SignUpPage">Sign Up</a>
            </div>
            <div class="header-background" id="headerBackground"></div>
        </nav>

        <!-- Background -->
        <div class="animated-background">
            <canvas id="background"></canvas>
            <script src="js/animated-background.js"></script>
        </div>

        <!-- Main -->
        <div class="content-container">
            <div class="row content-child">
                <div class="col col-md-5">
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
                    <img src="https://raw.githubusercontent.com/giangntse150746/xamxidu/main/img/codementor-for-teams.svg" alt="About us Image">
                </div>
            </div>

            <div class=" row content-child">
                <div class="col col-md-2">
                    <img class="" src="images/pinnacle.jpg" alt="Top Image" 
                         style="width: 120%; height: auto">
                </div>
                <div class="col col-md-6">
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
                        <form action="SignUpPage" method="POST">
                            <input type="submit" class="btn btn-dark" 
                                   value="Join us, let yourself be known">
                        </form>
                    </div>
                </div>    
            </div>
            <div id="carouselExampleControls" class="carousel slide content-child" data-ride="carousel">
                <div class="carousel-inner">
                    <c:forEach var="mentor" items="${comDAO.bestMentor}">
                        <c:set var="dto" value="${usersDAO.getProfile(mentor)}" />
                        <div class="carousel-item active">
                            <img class="d-block w-100" src="./images/${mentor}.jpg" alt="First slide">

                            <div id="toggle-info">

                            </div>
                        </div>
                    </c:forEach>
                </div>
                <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div>
            <%--
                    <div id="mentorsList" style="margin-top: 20%; color: white;">
                        <h1 class="text-warning test-right">Some of our best</h1>
                        <table border="1" class="text-middle">
                            <thead>
                                <tr class="text-light">
                                    <th class="col-md-4">Avatar</th>
                                    <th class="col-md-4">Mentor's Name</th>
                                    <th class="col-md-4">Skills</th>
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
                                        if ($(this).css("opacity") === 0) {
                                            $(this).fadeTo(300, 1);
                                        }
                                    } else {
                                        if ($(this).css("opacity") === 1) {
                                            $(this).fadeTo(100, 0);
                                        }
                                    }
                                });
                            }).scroll(); //invoke scroll-handler on page-load
                        }
                        );
                    </script>
            --%>
            <%--
            <script>
                var href = window.location.href;
                var mainURL = href.substring(0, href.indexOf(href.split("/")[4]));
            </script>
            --%>
        </div>
    </body>
    <script src="js/guest_homepage.js"></script>
</html>
