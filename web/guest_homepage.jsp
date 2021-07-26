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
    <%--
        <jsp:useBean id="comDAO" class="hps.comments.CommentsDAO" scope="request"/>
        <jsp:useBean id="usersDAO" class="hps.users.UsersDAO" scope="request"/>
        <jsp:useBean id="mentorSkillsDAO" class="hps.mentorSkills.MentorSkillsDAO" scope="request"/>
        <jsp:useBean id="skillsDAO" class="hps.skills.SkillsDAO" scope="request"/>
    --%>
    </head>
    <body>
        <!-- Header -->
        <nav class="navbar navbar-light w-100">
            <div class="navbar-brand">
                <a class="animated-logo" href="/HappyProgramming">
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
                <c:if test="${empty sessionScope.CURRENT_USER}">
                    <a class="nav-link header-button" href="LoginPage">Log In</a>
                    <a class="nav-link header-button" href="SignUpPage">Sign Up</a>
                </c:if>
                <c:if test="${not empty sessionScope.CURRENT_USER}">
                    <c:set value="${sessionScope.CURRENT_USER}" var="user"/>
                    <a class="nav-link header-button" href="/HappyProgramming"
                       style="font-family: Segoe UI">
                        Welcome, ${user.fullname}</a>
                </c:if>
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
                    <h1 class="text-success text-stroke display-1"
                        style="text-transform: uppercase">
                        Greetings!
                    </h1>
                    <h2 class="text-warning">Who we are: </h2>
                    <p class="text-light h4">
                        A group of young, aspiring, and dedicated individuals seeking
                        to harbour a haven to nourish the talents of the like-minded.
                    </p>
                    <p class="text-light h4">
                        We wholly dedicate ourselves to the quest of providing servitude
                        to whoever in needs, and thus endeavour to achieve the ultimate goal of
                        humanity's betterment as a whole.
                    </p>
                </div>
                <div class="col col-md-3">
                    <img src="https://raw.githubusercontent.com/giangntse150746/xamxidu/main/img/codementor-for-teams.svg" alt="About us Image">
                </div>
            </div>
            <div class="break-line"></div>
            
            <div class=" row content-child">
                <div class="col col-md-3">
                    <img class="" src="https://raw.githubusercontent.com/giangntse150746/xamxidu/main/img/visit-arc.svg" alt="Top Image" 
                         style="margin-top: 64px">
                </div>
                <div class="col col-md-5">
                    <div class="text-right">
                        <p class="text-success text-stroke lead strong" 
                           style="font-family: requiem; font-size: 2em">
                            Cum scientia et dedication, 
                            nos de servitute voverint reddent
                        </p>
                        <h1 class="text-warning" style="transition: .3s">Meet our ingenious minds!</h1>
                        
                        <p class="text-light h4">
                            We recruit only individuals who possess the essence 
                            of <br/> humanity's wisdom.<br/>
                            Those who wield the pinnacles of the technological realm.<br/>
                            Masters of the most abstruse Algorithms.<br/>
                            Creators of unchained data.
                        </p>
                        <form action="SignUpPage" method="POST">
                            <input type="submit" class="btn btn-outline-success btn-lg"
                                   value="Join us! Let yourself be known">
                        </form>
                        <h2 class="text-light h5" hidden>
                            <a href="#mentorsList">
                                Meet the team first 
                            </a>
                        </h2>
                    </div>
                </div>  
            </div>
            <div class="break-line"></div>
            
            <div class=" row content-child">
                <div class="col col-md-8">
                    <p class="text-success text-stroke display-1"
                        style="text-transform: uppercase">
                        professional
                    </p>
                    <h1 class="text-warning">Many certified and skillful mentors:</h1>
                    
                </div>
            </div>
            <%--
            <c:set var="" value="${requestScope.BEST_MENTOR}"/>
            <div id="carouselExampleControls" class="carousel slide content-child" data-ride="carousel">
                <div class="carousel-inner">
                    <c:forEach var="mentor" items="${comDAO.bestMentor}">
                        <c:set var="dto" value="${usersDAO.getProfile(mentor)}" />
                        <div class="carousel-item active">
                            <img class="d-block w-100" src="./images/${mentor}.jpg" alt="First slide">
                            
                            <div id="toggle-info">
                                <p>
                                    Name:
                                </p>
                                <p>
                                    Skill:
                                </p>
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
            --%>
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
