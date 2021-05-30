<%-- 
    Document   : admin_viewAllMentor
    Created on : May 30, 2021, 6:20:56 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View all mentor</title>
    </head>
    <body>
        <form action="AdminViewAllMentor" method="POST">
            <input type="text" name="searchValue" value="${param.searchValue}"/>
            <input type="submit" value="Search" />
        </form>
        <c:if test="${not empty requestScope.LIST_MENTORS_ID}">
            <c:set var="listMentorsID" value="${requestScope.LIST_MENTORS_ID}"/>
            <table border="1">
                <thead>
                    <tr>
                        <th>STT</th>
                        <th>ID</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="mentorID" items="${listMentorsID}" varStatus="counter">
                        <tr>
                            <td>
                                ${counter.count}
                            </td>
                            <td>
                                ${mentorID}
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
        <a href="AdminHomePage">Back to homepage</a>
        <script>
//            function viewAll(){
//                var form = document.getElementById("myForm");
//                if(form.visited.value == ""){
//                    form.submit();
//                    form.visited.value = "1";
//                }else{}
//            }
        </script>
    </body>
</html>
