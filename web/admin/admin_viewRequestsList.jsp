<%-- 
    Document   : admin_viewRequestsList
    Created on : Jun 8, 2021, 8:11:56 PM
    Author     : Tran Phong <phongntse150974@fpt.edu.vn>
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="x-ua-compatible" content="ie=edge">

        <link rel="stylesheet" href="css/bootstrap/bootstrap.min.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.css">
        <title>View Requests List</title>
    </head>
    <body>
        <div class="wrapper">
            <c:set var="user" value="${sessionScope.CURRENT_USER}" scope="page"/>
            <c:if test="${empty user}">
                <c:redirect url="LoginPage" />
            </c:if>
            <c:if test="${not fn:startsWith(user.userID, 'AD')}">
                <c:redirect url="/" />
            </c:if>

            <header>
                <!--Menu-->
                <jsp:include flush="true" page="adminMenu.jsp">
                    <jsp:param name="page" value="requestsList"/>
                </jsp:include>
            </header>

            <main>
                <div id="content">
                    <jsp:include flush="true" page="/topMenu.jsp"/>
                    <h1>View List of Requests</h1>
                    <c:set var="pending" value="false" />
                    <c:set var="accepted" value="false" />
                    <c:set var="rejected" value="false" />
                    <c:set var="closed" value="false" />
                    <c:forEach var="item" items="${paramValues.status}">
                        <c:if test="${item eq 'P'}">
                            <c:set var="pending" value="true" />
                        </c:if>
                        <c:if test="${item eq 'A'}">
                            <c:set var="accepted" value="true" />
                        </c:if>
                        <c:if test="${item eq 'R'}">
                            <c:set var="rejected" value="true" />
                        </c:if>
                        <c:if test="${item eq 'C'}">
                            <c:set var="closed" value="true" />
                        </c:if>
                    </c:forEach>
                    <div class="row">
                        <div class="col-8">
                            <form action="AdminViewRequestsList">

                                <!--Search value--> 
                                <div class="form-group row">
                                    <label for="searchValue" class="col-4 col-form-label">Search</label>
                                    <div class="col-5">
                                        <input type="text" class="form-control" name="searchValue"
                                               value="${param.searchValue}" placeholder="Java, Algorithm..." aria-describedby="searchHelp"/>
                                        <small id="searchHelp" class="form-text text-muted">Enter value you want the request's content to contain, or leave blank to search all the requests</small>
                                    </div>
                                </div>

                                <!--Request Status-->
                                <div class="form-group row">
                                    <label for="searchValue" class="col-4 col-form-label">Request Status</label>
                                    <div class="col-5">
                                        <div class="form-check form-check-inline">
                                            <input aria-describedby="statusHelp" class="form-check-input" type="checkbox" name="status" value="P" id="pending" <c:if test="${pending eq 'true'}">checked=""</c:if> />
                                                <label class="form-check-label" for="pending">Pending</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="checkbox" name="status" value="A" id="accepted" <c:if test="${accepted eq 'true'}">checked=""</c:if> />
                                                <label class="form-check-label" for="accepted">Accepted</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="checkbox" name="status" value="R" id="rejected" <c:if test="${rejected eq 'true'}">checked=""</c:if> />
                                                <label class="form-check-label" for="rejected">Rejected</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="checkbox" name="status" value="C" id="closed" <c:if test="${closed eq 'true'}">checked=""</c:if> />
                                                <label class="form-check-label" for="closed">Closed</label>
                                            </div>
                                            <small id="statusHelp" class="form-text text-muted">You can't search Pending requests with a start or end date</small>
                                        </div>  
                                    </div>

                                    <!--Date--> 
                                    <div class="form-group row">
                                        <label for="startDate" class="col-4 col-form-label">Start Date</label>
                                        <div class="col-5">
                                            <input class="form-control" type="date" name="startDate" id="startDate" value="${param.startDate}" />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="endDate" class="col-4 col-form-label">End Date</label>
                                    <div class="col-5">
                                        <input aria-describedby="dateHelp" class="form-control"  type="date" name="endDate" id="endDate" value="${param.endDate}" />
                                        <small id="dateHelp" class="form-text text-muted">Filter the requests that have opened date after "Start Date" and closed / rejected date before "End Date</small>
                                    </div>
                                </div>
                                <div class='row'>
                                    <div class='col-5 offset-4'>
                                        <input class='btn btn-primary' type="submit" value="Search" name="btnSearch" />
                                    </div>
                                </div>


                            </form>
                            <br/>
                            <c:set var="error" value="${VIEW_REQUESTS_LIST_ERROR}" />
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger mt-2" role="alert">
                                ${error}
                                </div>
                            </c:if>

                            <c:set var="data" value="${REQUESTS_LIST}" />
                            <c:if test="${empty error and data.size() eq 0}">
                                <div class="alert alert-danger mt-2" role="alert">
                                No matched request is found!!
                                </div>
                            </c:if>
                            <c:if test="${not empty data}">
                                <em>Click on the request's ID to view its detail</em>
                                <table class='table table-bordered table-hover'>
                                    <thead class='thead-light'>
                                        <tr>
                                            <th class="align-middle" scope='col'>No.</th>
                                            <th class="align-middle" scope='col'>Request ID</th>
                                            <th class="align-middle" scope='col'>Mentee created request</th>
                                            <th class="align-middle" scope='col'>Request Title</th>
                                            <th class="align-middle" scope='col'>Request Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${data}" var="request" varStatus="count">
                                            <tr>
                                                <td class="align-middle" scope='row'>
                                                    ${count.count}
                                                </td>
                                                <td class="align-middle">
                                                    <c:url var="requestDetail" value="AdminViewRequestDetail">
                                                        <c:param name="requestID" value="${request.requestID}"/>
                                                        <c:param name="back" value="AdminViewRequestsList?${pageContext.request.queryString}" />
                                                    </c:url>
                                                    <a href="${requestDetail}">${request.requestID}</a>

                                                </td>
                                                <td class="align-middle">
                                                    ${request.menteeID}
                                                </td>
                                                <td class="align-middle">
                                                    ${request.title}
                                                </td>
                                                <td class="align-middle">
                                                    <c:choose>
                                                        <c:when test="${request.status eq 'A'}">
                                                            Accepted
                                                        </c:when>
                                                        <c:when test="${request.status eq 'P'}">
                                                            Pending
                                                        </c:when>
                                                        <c:when test="${request.status eq 'R'}">
                                                            Rejected
                                                        </c:when>
                                                        <c:when test="${request.status eq 'C'}">
                                                            Closed
                                                        </c:when>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                                <nav aria-label='Request Page Navigation'>
                                    <ul class='pagination'>
                                <c:forEach var="i" begin="1" end="${requestScope.NUM_PAGES}">
                                    <c:url var="url" value="AdminViewRequestsList">

                                        <c:param name="searchValue" value="${param.searchValue}"/>
                                        <c:forEach var="item" items="${paramValues.status}">
                                            <c:param name="status" value="${item}" />
                                        </c:forEach>
                                        <c:param name="startDate" value="${param.startDate}" />
                                        <c:param name="endDate" value="${param.endDate}" />
                                        <c:param name="page" value="${i}"/>
                                    </c:url>
                                    
                                    <c:set var="pagination" value="${param.page}" />
                                    <c:if test="${empty pagination}">
                                        <c:set var="pagination" value="${1}" />
                                    </c:if>
                                    <c:if test="${pagination eq i}">
                                        <li class='page-item active'><span class='page-link'>${i}</span></li>
                                    </c:if>
                                    <c:if test="${pagination ne i}">
                                        <li class='page-item'><a class='page-link' href="${url}">${i}</a></li>
                                    </c:if>
                                </c:forEach>
                                    </ul>
                                </nav>
                            </c:if>
                        </div>
                        <div class="col-4">

                        </div>
                    </div>
                </div>
            </main>
        </div>

        <!-- The infor of the list of request include: 
        STT, 
        ID (Click to view Detail), 
        accountname (who create request), 
        title of request, 
        status.-->
        <script src = "js/jquery/jquery-3.6.0.min.js"></script>
        <script src = "js/popper/popper.min.js"></script>
        <script src = "js/bootstrap/bootstrap.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.concat.min.js"></script>
        <script src="js/menu.js"></script>
        <script src="admin/js/admin_viewRequestsList.js"></script>
    </body>
</html>
