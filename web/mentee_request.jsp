<%-- 
    Document   : mentee_request
    Created on : May 22, 2021, 8:48:34 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create request</title>
    </head>
    <body>
        <form action="MenteeRequest" method="POST">
            <c:set var="error" value="${requestScope.REQUEST_ERROR}"/>
            Title: <input type="text" name="title" value="${param.title}"><br/>
            <c:if test="${not empty error.titleLengthError}" >
                <font color="red">${error.titleLengthError}</font><br/>
            </c:if>
            Deadline date (year-month-day): <input type="text" name="deadlineDate" value="${param.deadlineDate}" /><br/>
            Deadline hour (hour:minute): <input type="text" name="deadlineHour" value="${param.deadlineHour}" /><br/>
            <c:if test="${not empty error.deadlineDateTimeError}" >
                <font color="red">${error.deadlineDateTimeError}</font><br/>
            </c:if>
            <c:if test="${not empty error.deadlineError}" >
                <font color="red">${error.deadlineError}</font><br/>
            </c:if>
            Content: <br/> <textarea name="content" rows="4" cols="30"></textarea><br/>
            <c:if test="${not empty error.contentLengthError}" >
                <font color="red">${error.contentLengthError}</font><br/>
            </c:if>
            Select skill (1-3): <br/>
            <input type="checkbox" name="ckb" value="Java" onclick="return chkControl()" />Java <br/>
            <input type="checkbox" name="ckb" value="CSharp" onclick="return chkControl()"/>CSharp<br/>
            <input type="checkbox" name="ckb" value="PHP" onclick="return chkControl()"/>PHP<br/>
            <input type="checkbox" name="ckb" value="Perl" onclick="return chkControl()"/>Perl<br/>
            <input type="checkbox" name="ckb" value="Ruby" onclick="return chkControl()"/>Ruby<br/>
            <c:if test="${not empty error.ckbError}" >
                <font color="red">${error.ckbError}</font><br/>
            </c:if>
            Your mentor ID: <input type="text" name="mentorID" value="${param.mentorID}" /><br/>
            <c:if test="${not empty error.mentorIDConflictError}" >
                <font color="red">${error.mentorIDConflictError}</font><br/>
            </c:if>

            <input type="submit" value="OK" name="btnAction" onclick="valCkb()"/>
        </form>

        <script>
            function chkControl() {
                var a = document.getElementsByName("ckb");
                var total = 0;
                var count;
                for (count = 0; count < a.length; count++) {
                    if (a[count].checked == true) {
                        total = total + 1;
                    }
                }
                if (total > 3 || total < 1) {
                    alert("Select at least 1, at most 3");
                    return false;
                }
            }
            function valCkb()
            {
                var checkboxs = document.getElementsByName("ckb");
                var iCheck = false;
                for (var i = 0; i < checkboxs.length; i++)
                {
                    if (checkboxs[i].checked)
                    {
                        iCheck = true;
                        break;
                    }
                }
                if (iCheck){
                    
                }else
                    alert("Please select at least 1 skill");
            }
        </script>
    </body>
</html>
