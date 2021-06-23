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
        <link rel="stylesheet" href="css/general.css">
        <link rel="stylesheet" href="css/guest_homepage.css">
        <!-- Source for animated background -->
        <link rel="stylesheet" href="css/animated-background.css">
        <!-- External ref -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
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
        <%--
        <script>
            var href = window.location.href;
            var mainURL = href.substring(0, href.indexOf(href.split("/")[4]));
        </script>
        --%>
    </body>
</html>
