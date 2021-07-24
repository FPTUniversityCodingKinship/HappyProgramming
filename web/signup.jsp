<%-- 
    Document   : signup
    Created on : May 23, 2021, 6:56:28 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Account</title>
        <link rel="icon" href="images/favicon.ico">
        <link rel="stylesheet" href="css/general.css">
    </head>
    <body>
        <a href="/HappyProgramming/"> Back to Homepage</a>
        <h1>JOIN OUR COMMUNITY NOW!!!</h1>
        <br/>
        <form action="SignUp" method="POST">
            <c:set var="errors" value="${requestScope.CREATE_ERROR}"/>
            <table border="0">
                <c:if test="${not empty errors.userIDFailedToGenerate}">
                <tr>
                    <td colspan="2">
                        <font color="red">
                            ${errors.userIDFailedToGenerate}
                        </font>
                    </td>
                </tr>
                </c:if>
                        <%-- Email --%>
                <tr>
                    <td>
                        Email*
                    </td>
                    <td>
                        <input type="email" name="txtEmail" 
                               value="${param.txtEmail}"
                               placeholder=" (example@gmail.com)"/>
                    </td>
                </tr>
                <c:if test="${not empty errors.emailInvalid}">
                <tr>
                    <td colspan="2">
                        <font color="red">
                            ${errors.emailInvalid}
                        </font>
                    </td>
                </tr>
                </c:if>
                <c:if test="${not empty errors.emailIsExisted}">
                <tr>
                    <td colspan="2">
                    <font color="red">
                        ${errors.emailIsExisted}
                    </font><br/>
                    </td>
                </tr>
                </c:if>
                        <%-- Username --%>
                <tr>
                    <td>
                        Username*
                    </td>
                    <td>
                        <input type="text" name="txtUsername" 
                               value="${param.txtUsername}"
                               placeholder=" (6-30 chars | letters, numbers)"/>
                    </td>
                </tr>
                <c:if test="${not empty errors.usernameLengthErr}">
                <tr>
                    <td colspan="2">
                        <font color="red">
                            ${errors.usernameLengthErr}
                        </font>
                    </td>
                </tr>
                </c:if>
                <c:if test="${not empty errors.usernameIsExisted}">
                <tr>
                    <td colspan="2">
                        <font color="red">
                            ${errors.usernameIsExisted}
                        </font>
                    </td>
                </tr>
                </c:if>
                        <%-- Password --%>
                <tr>
                    <td>
                        Password*
                    </td>
                    <td>
                        <input type="password" name="txtPassword" 
                               value=""
                               placeholder=" (6-20 chars | letters, numbers)"/>
                    </td>
                </tr>
                <c:if test="${not empty errors.passwordLengthErr}">
                <tr>
                    <td colspan="2">
                        <font color="red">
                            ${errors.passwordLengthErr}
                        </font>
                    </td>
                </tr>    
                </c:if>
                        <%-- Confirm Password --%>
                <tr>
                    <td>
                        Confirm Pass*
                    </td>
                    <td>
                        <input type="password" name="txtConfirm" value=""
                               placeholder=" (matching the password)"/>
                    </td>
                </tr>
                <c:if test="${not empty errors.confirmNotMatch}">
                <tr>
                    <td colspan="2">
                        <font color="red">
                            ${errors.confirmNotMatch}
                        </font>
                    </td>
                </tr>
                </c:if>
                        <%-- Fullname --%>
                <tr>
                    <td>
                        Full Name*
                    </td>
                    <td>
                        <input type="text" name="txtFullname"
                               value="${param.txtFullname}"
                               placeholder=" (2-50 chars | letters, space)"/>
                    </td>
                </tr>
                <c:if test="${not empty errors.fullnameLengthErr}">
                <tr>
                    <td colspan="2">
                        <font color="red">
                            ${errors.fullnameLengthErr}
                        </font>
                    </td>
                </tr>
                </c:if>
                    <%-- Sex --%>
                <tr>
                    <td>
                        Sex*
                    </td>
                    <td>
                        <input type="radio" id="fmale" name="txtSex" value="M" checked/>
                        <label for="fmale">Female</label>
                        <input type="radio" id="male" name="txtSex" value="M"/>
                        <label for="male">Male</label>
                        <input type="radio" id="other" name="txtSex" value="M"/>
                        <label for="other">Other</label>
                    </td>
                </tr>
                        <%-- Birthday --%>
                <tr>
                    <td>
                        Birthday*
                    </td>
                    <td>
                        <input type="date" name="txtDob" 
                               value="${param.txtDob}"/>
                    </td>
                </tr>
                <c:if test="${not empty errors.dobInvalid}">
                <tr>
                    <td colspan="2">
                        <font color="red">
                            ${errors.dobInvalid}
                        </font>
                    </td>
                </tr>
                </c:if>
                        <%-- Address --%>
                <tr>
                    <td>
                        Address*
                    </td>
                    <td>
                        <input type="text" name="txtAddress" 
                               value="${param.txtAddress}"
                               placeholder=" (..., province/state, country)"/>
                    </td>
                </tr>
                <c:if test="${not empty errors.addressInvalid}">
                <tr>
                    <td colspan="2">
                        <font color="red">
                            ${errors.addressInvalid}
                        </font>
                    </td>
                </tr>
                </c:if>
                        <%-- Phone Number --%>
                <tr>
                    <td>
                        Phone Number*
                    </td>
                    <td>
                        <input type="text" name="txtPhone" 
                               value="${param.txtPhone}"
                               placeholder=" (9-12 digits)"/>
                    </td>
                </tr>
                <c:if test="${not empty errors.phoneInvalid}">
                <tr>
                    <td colspan="2">
                        <font color="red">
                            ${errors.phoneInvalid}
                        </font>
                    </td>
                </tr>
                </c:if>
            </table>
            <input type="submit" value="Create New Account"/>
            <input type="reset" value="Reset"/>
        </form>
    </body>
</html>
