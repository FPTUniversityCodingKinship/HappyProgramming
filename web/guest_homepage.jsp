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
                      style="width: 320px; float: left; margin-left: 12px" hidden>
                    <input class="form-control" type="search" action="#"
                           placeholder="Search something..." aria-label="Search">
                    <div class="input-group-append">
                        <button class="btn btn-success" type="submit">Search</button>
                    </div>
                </form>
                <a href="/HappyProgramming" style="text-decoration: none;">
                    <p class="h1 bold-text" style="color: #fff" id="headerName">
                        HAPPY PROGRAMMING
                    </p>
                </a>
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
                    <h2 class="text-warning h3">Who we are: </h2>
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
                        <h1 class="text-warning h3" style="transition: .3s">
                            Meet our ingenious minds!
                        </h1>
                        
                        <p class="text-light h4">
                            We recruit only individuals who possess the essence 
                            of <br/> humanity's wisdom.<br/>
                            Those who wield the pinnacles of the technological realm.<br/>
                            Masters of the most abstruse Algorithms.<br/>
                            Creators of unchained data.
                        </p>
                        
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
                    <p class="text-success text-stroke display-4"
                        style="text-transform: uppercase">
                        professional
                    </p>
                    <h1 class="text-warning h3">
                        Many certified and skillful mentors...
                    </h1>
                    <form action="SignUpPage" method="POST">
                        <input type="submit" class="btn btn-outline-success btn-lg"
                               value="Join us! Let yourself be known">
                    </form>
                    <%--
                    <c:set var="mentors" value="${requestScope.MENTOR_LIST}"/>
                    <c:forEach var="dto" items="${mentors}" varStatus="counter">
                        <div class="mentor-container">
                            <div class="mt-left">
                                <img class="img-thumbnail" src="./images/${user.image}" 
                                     alt="The user's avatar" width="128">
                            </div>
                            <div class="mt-right">
                                
                            </div>
                        </div>
                    </c:forEach>
                    --%>
                </div>
            </div>
            
        </div>
    </body>
    <script src="js/guest_homepage.js"></script>
</html>
