<%-- 
    Document   : guest_homepage
    Created on : Jun 1, 2021, 5:06:06 PM
    Author     : Admin
--%>

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
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script type="module"  src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js"></script>
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

        <div class="row fade-in" style="margin-top: 30%">
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
            <script>
                $(window).on("load", function () {
                    $(window).scroll(function () {
                        var windowBottom = $(this).scrollTop() + $(this).innerHeight();
                        $(".fade-in").each(function () {
                            /* Check the location of each desired element */
                            var objectBottom = $(this).offset().top + $(this).outerHeight();

                            /* If the element is completely within bounds of the window, fade it in */
                            if (objectBottom < windowBottom) { //object comes into view (scrolling down)
                                if ($(this).css("opacity") == 0) {
                                    $(this).fadeTo(2000, 1);
                                }
                            } else { //object goes out of view (scrolling up)
                                if ($(this).css("opacity") == 1) {
                                    $(this).fadeTo(500, 0);
                                }
                            }
                        });
                    }).scroll(); //invoke scroll-handler on page-load
                });
            </script>
        </div>

    </body>
</html>
