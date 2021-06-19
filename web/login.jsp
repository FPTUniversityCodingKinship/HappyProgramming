<%-- 
    Document   : login
    Created on : May 22, 2021, 6:07:10 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <link rel="stylesheet" href="css/general.css">

    </head>
    <body style="background-image: linear-gradient(90deg, #0869B2 0%, #0869B2 33%, #EA6E26 33%, #EA6E26 66%, #0EB34A 66%, #0EB34A 100%);
          ">
        <h1>LOG IN HERE!!!</h1>
        <c:set var="errors" value="${requestScope.LOGIN_ERROR}"/>
        <form method="POST" action="Login">
            <table border="0">
                <tr>
                    <td>
                        Username
                    </td>
                    <td>
                        <input type="text" name="txtUsername" 
                               value="${param.txtUsername}"/>
                    </td>
                </tr>
                <c:if test="${not empty errors.usernameLengthErr}">
                    <tr>
                        <td colspan="2" style="text-align: center">
                            <font color="red">
                            ${errors.usernameLengthErr}
                            </font>
                        </td>
                    </tr>
                </c:if>
                <tr>
                    <td>
                        Password
                    </td>
                    <td>
                        <input type="password" name="txtPassword" value=""/>
                    </td>
                </tr>
                <c:if test="${not empty errors.passwordLengthErr}">
                    <tr>
                        <td colspan="2" style="text-align: center">
                            <font color="red">
                            ${errors.passwordLengthErr}
                            </font>
                        </td>
                    </tr>
                </c:if>
                <c:if test="${not empty errors.loginInfoNotMatch}">
                    <tr>
                        <td colspan="2" style="text-align: center">
                            <font color="red">${errors.loginInfoNotMatch}</font>
                        </td>
                    </tr>
                </c:if>
                <tr>
                    <td>
                        Remember User?
                    </td>
                    <td>
                        <input type="checkbox" name="chkCookie" value="ON" />
                    </td>
                </tr>
            </table> 
            <input type="submit" value="LOG IN" class="btn">
            <input type="reset" value="RESET" class="btn">
        </form>
        <a href="SignUpPage">Create new account</a>
    </body>
</html>