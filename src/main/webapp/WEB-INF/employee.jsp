<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="/css/bootstrap.css">
	<script
    src="https://code.jquery.com/jquery-3.2.1.js"
    integrity="sha256-DZAnKJ/6XZ9si04Hgrsxu/8s717jcIzLy3oi35EouyE="
    crossorigin="anonymous"></script>
	<title>Employees</title>
</head>
<body>
<h1 class="jumbotron">  Dashboard</h1>

<div class="container">
    <form id="logoutForm" method="POST" action="/logout">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <button class="btn btn-warning" type="submit"> Logout</button>
    </form>
<h1>Welcome ${currentUser.firstname}  </h1>       
<p class="text-right">
<form action="/employees/shift/sign">
<button class="pure-button button btn btn-success" type="button">Get my location</button>
Latitude:<input type="text" id="latitude" name="latitude" readonly />
Longitude: <input type="text" id="longitude" name="longitude" readonly />
       </p>
<table class="table table-hover table-striped">
<thead>
	<tr>
		<th> Shift Location </th>
		<th> Shift Date </th>
		<th> Shift Time In </th>
		<th> Shift Time Out </th>
		<th> Actual Time In </th>
		<th> Actual Time Out</th>
		<th> Actions </th>
	</tr>
</thead>
<tbody>
	<c:forEach var="shift" items="${shifts}">
		<jsp:useBean id="now" class="java.util.Date" />
		<fmt:formatDate var="today" value="${now}" pattern="yyyy-MM-dd" />
		<fmt:formatDate var="date" value="${shift.assignedDate}" pattern="yyy-MM-dd"/>
		<c:if test="${date gt today || date eq today}">
			<tr>
				<td> ${shift.location.name} - ${shift.location.address} </td>
				<td> <fmt:formatDate pattern="MM/dd/yyyy" value="${shift.assignedDate}" /></td>
				<td> <fmt:formatDate pattern="hh:mm a" value="${shift.assignedSignIn}" /></td>
				<td> <fmt:formatDate pattern="hh:mm a" value="${shift.assignedSignOut}" /></td>
				<td> <fmt:formatDate pattern="hh:mm a" value="${shift.signIn}" /></td>
				<td> <fmt:formatDate pattern="hh:mm a" value="${shift.signOut}" /></td>
				<td> 
					

				<c:choose>
					<c:when test="${shift.signIn==null}">				
					<button class="btn btn-primary" type="submit" name="shift" value="${shift.id}"> Sign in</button>
					</c:when>
					<c:otherwise>			
					<button class="btn btn-warning" type="submit" name="shift" value="${shift.id}"> Sign out</button>
					</c:otherwise>
				</c:choose>
					
				</td>
			</tr>
		</c:if>
	</c:forEach>

</tbody>

</table>
</form>
 <script type="text/javascript" src="/js/currentLocation.js"></script>
</body>
</html>