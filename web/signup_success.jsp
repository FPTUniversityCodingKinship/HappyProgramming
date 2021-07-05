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
    </head>
    <body>
        <h1>Your Account is Successfully created</h1>
        <p>
            We are preparing for your best experience.<br/>
            To make sure you are not a robot, please do for us<br/>
            one last step is to verify your account.<br/>
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
                location.href = location.origin + "/Login?" + params;
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
                            window.location.href = origin + "/Login?" + params;
                        else
                            alert("Something went wrong...");
                    }, 1000);
                }, 1000);
            }, 1000);
        });
    </script>
</html>
