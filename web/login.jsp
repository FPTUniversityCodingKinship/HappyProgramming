<%-- 
    Document   : login
    Created on : May 22, 2021, 6:07:10 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <meta name="google-signin-client_id" 
              content="401908117605-vofu7m8maarbv0c6remdnf8n1r568060.apps.googleusercontent.com">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
        <script src="https://accounts.google.com/gsi/client" async defer></script>
    </head>
    <body>
        <h1>LOG IN HERE!!!</h1>
        <form method="POST" action="Login">
            Username: <input type="text" name="txtUsername" value="" /> 
            Password: <input type="password" name="txtPassword" value="" />
            <input type="submit" value="LOG IN" />
        </form>
        <%--
        <div id="my-signin2"></div>
        <img id="myImg"><br/>
        <p>Welcome, <span id="myName"></span></p>
        <div id="status"></div>
        <a href="#" onclick="signOut();">Sign out</a>
        <script>
            function onSuccess(googleUser) {
                var auth2 = gapi.auth2.getAuthInstance();
                if (auth2.isSignedIn.get()) {
                    var profile = auth2.currentUser.get().getBasicProfile();
                    console.log('ID: ' + profile.getId());
                    console.log('Full Name: ' + profile.getName());
                    console.log('Given Name: ' + profile.getGivenName());
                    console.log('Family Name: ' + profile.getFamilyName());
                    console.log('Image URL: ' + profile.getImageUrl());
                    console.log('Email: ' + profile.getEmail());
                    
                    document.getElementById("myName").innerHTML += profile.getName();
                    document.getElementById("myImg").src = profile.getImageUrl();
                    
                    setTimeout(function() {
                        document.location.href = '/HappyProgramming/LoginSuccess';
                    },1000);
                }
                // The ID token you need to pass to your backend:
                var id_token = googleUser.getAuthResponse().id_token;
                console.log("ID Token: " + id_token);
            }
            function onFailure(error) {
                console.log(error);
            }
            function renderButton() {
                gapi.signin2.render('my-signin2', {
                    'scope': 'profile email',
                    'width': 240,
                    'height': 50,
                    'longtitle': true,
                    'theme': 'dark',
                    'onsuccess': onSuccess,
                    'onfailure': onFailure
                });
            }
            function signOut() {
                var auth2 = gapi.auth2.getAuthInstance();
                auth2.signOut().then(function () {
                  console.log('User signed out.');
                });
                gapi.auth2.getAuthInstance().disconnect();
                location.reload();
            }
        </script>
        <script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>
    --%>
    </body>
</html>
