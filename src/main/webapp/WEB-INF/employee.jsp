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
	<link rel="stylesheet" type="text/css" href="/css/dashboard.css">
	<script
    src="https://code.jquery.com/jquery-3.2.1.js"
    integrity="sha256-DZAnKJ/6XZ9si04Hgrsxu/8s717jcIzLy3oi35EouyE="
    crossorigin="anonymous"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script type="text/javascript" src="/js/employees.js"></script>    

    
	<title>Employees</title>
</head>
<body>
	<div class="top">
	<div class="col-md-4 col-md-offset-6 logo">
	<img src="/img/logo_grey2.png" class="logoImg"></div>
	</div>
	



<div class="container">
	<div class="text-right">
	<a class="aniLink" href="/employees/previousShifts">Previous Shifts</a> | 
	<a class="aniLink" href="/login?logout"> Log out</a>
	</div>
	<div>   
	
	<h4> Upcoming Shifts</h4>
   	<form action="/employees/shift/sign"> 
	<div class="text-right">
		<div class="form-group">
		<div class="row">
			<div class="col">
			<p> Latitude:<input type="text" id="latitude" name="latitude" readonly class="form-control"/> </p></div>
			<div class="col">
			<p> Longitude: <input type="text" id="longitude" name="longitude" readonly class="form-control" /> </p></div>
		</div>
	<button class="pure-button button btn btn-patone btn-block" type="button">Get my location and sign in</button>
	</div>
	
<div id="shiftTable">
<table class="table table-hover">
<thead class="thead-inverse">
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
					<c:if test="${date eq today}">			
					<button class="btn btn-patone" type="submit" name="shift" value="${shift.id}"> Sign in</button>
					</c:if>
					</c:when>
					<c:otherwise>			
					<button class="btn btn-patone" type="submit" name="shift" value="${shift.id}"> Sign out</button>
					</c:otherwise>
				</c:choose>
					
				</td>
			</tr>
		</c:if>
	</c:forEach>

</tbody>

</table>
</div>
</form>
 <script type="text/javascript" src="/js/currentLocation.js"></script>
</body>
</html>