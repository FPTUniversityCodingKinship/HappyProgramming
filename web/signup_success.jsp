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
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
        <script type="module"  src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js"></script>
        
    </head>
    <body>
        <h1>Your Account has been successfully created</h1>
        <p>
            We are preparing for your best experience.<br/>
            To make sure you are not a robot, please verify your account<br/>
        </p>
        <p>
            <a onclick="sendMail();">Click here</a> to send verify mail now
                    or wait for <span id="countdown"></span> second(s).
        </p>
    </body>
    <script>
        var params = window.location.href.split("?")[1];
        function sendMail() {
            if (params !== null)
                location.href = location.origin + "/HappyProgramming";
            else
                alert("Something went wrong...");
        }
        $(document).ready(function(){
            var countDown = document.getElementById("countdown");
            countDown.innerHTML = '3';
            setTimeout(function() {
                countDown.innerHTML = '2';
                setTimeout(function () {
                    countDown.innerHTML = '1';
                    setTimeout(function () {
                        countDown.innerHTML = '0';
                        var origin = window.location.origin;
                        if (params !== null)
                            window.location.href = origin + "/HappyProgramming";
                        else
                            alert("Something went wrong...");
                    }, 1000);
                }, 1000);
            }, 1000);
        });
    </script>
</html>
