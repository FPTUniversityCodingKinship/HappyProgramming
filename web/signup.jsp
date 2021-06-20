<%-- 
    Document   : signup
    Created on : May 23, 2021, 6:56:28 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Account</title>
    </head>
    <body>
        <a href=""> Back to Homepage</a>
        <h1>JOIN OUR COMMUNITY NOW!!!</h1>
        <br/>
        <form action="registerAction" method="POST">
            <c:set var="errors" value="${requestScope.CREATE_ERROR}"/>
            <table border="0">
                        <%-- Email --%>
                <tr>
                    <td>
                        Email*
                    </td>
                    <td>
                        <input type="email" name="txtEmail" 
                               value="${param.txtEmail}"/>
                    </td>
                </tr>
                        <%-- Username --%>
                <tr>
                    <td>
                        Username*
                    </td>
                    <td>
                        <input type="text" name="txtUsername" 
                               value="${param.txtUsername}"/> (6-30 chars)
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
                    <font color="red">
                        ${errors.usernameIsExisted}
                    </font><br/>
                </c:if>
                        <%-- Password --%>
                <tr>
                    <td>
                        Password*
                    </td>
                    <td>
                        <input type="password" name="txtPassword" 
                               value=""/> (6-20 chars)
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
                        <input type="password" name="txtConfirm" value=""/>
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
                                   value="${param.txtFullname}"/>(2-50 chars)
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
                                   value="${param.txtAddress}"/>
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
                                   value="${param.txtPhone}"/>
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
            <input type="submit" value="Create New Account" name="btnAction"/>
            <input type="reset" value="Reset"/>
        </form>
    </body>
</html>
