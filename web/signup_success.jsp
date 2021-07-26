<%-- 
    Document   : signup_success
    Created on : Jun 22, 2021, 11:17:43 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sign Up Success</title>
        <link rel="icon" href="images/favicon.ico">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
        <script type="module"  src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js"></script>
        <link rel="stylesheet" href="css/general.css">
        <style>
            body {
                background-color: #2D333B;
            }
            .text-center {
                text-align: center;
            }
        </style>
    </head>
    <body>
        <form action="Logout" id="Logout">
            <p id="Welcome" class="text-right" style="margin: 16px;">
                <input type="submit" value="Logout" class="btn btn-outline-danger"/>
            </p>
        </form>
        <div class="text-center" style="color: #fff">
            <img src="images/main-logo.png" alt="" width="320">
            <h1 class="text-success" style="margin-bottom: 12px;">
                Your Account has been successfully created
            </h1>
            <p class="text-info h5">
                We are preparing for your best experience.<br/>
                To make sure you are not a robot, please verify your account<br/>
            </p>
            <p class="h5">
                <a href="#" onclick="sendMail();" class="h5" style="text-decoration: none">
                    Click here
                </a>
                to send verify mail now or wait for
                <span id="countdown" class="h5"></span> second(s).
            </p>
        </div>
    </body>
    <script>
        var countdown = 10;
        var params = window.location.href.split("?")[1];
        function sendMail() {
            countdown = 0;
        }
        $(document).ready(function () {
            setInterval(function () {
                if (countdown === 0) {
                    document.location = "/HappyProgramming";
                    countdown -= 1;
                } else if (countdown > 0) {
                    document.getElementById('countdown').innerHTML = countdown;
                    countdown -= 1;
                }
            }, 1000);
        });
    </script>
</html>
