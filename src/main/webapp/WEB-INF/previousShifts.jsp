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
	<title>Employers</title>
</head>
<body>

	<div class="top">
	<div class="col-md-4 col-md-offset-6 logo">
	<img src="/img/logo_grey2.png" class="logoImg"></div>
	</div>
	
<div class="container">	
	<div class="text-right">
	<a class="aniLink" href="/login?logout"> Log out</a>
	</div>



<h4> Previous Shifts</h4>
<div id="shiftTable">
<table class="table table-hover">
<thead class="thead-inverse">
	<tr>
		<th> Employee  </th>
		<th> Location </th>
		<th> Date </th>
		<th> FROM</th>
		<th> TO </th>
		<th> Actual Time In </th>
		<th> Actual Time Out</th>
	</tr>
</thead>
<tbody>
	<c:choose>
	<c:when test="${shifts.size() == 0 }">
		<tr>
			<td colspan="8"> No previous shifts </td>
		</tr>
	</c:when>
	<c:otherwise>
	


	<c:forEach var="shift" items="${shifts}">
			<tr>
				<td> ${shift.employee.firstname} ${shift.employee.lastname } </td>
				<td> ${shift.location.name} </td>
				<td> <fmt:formatDate pattern="MM/dd/yyyy" value="${shift.assignedDate}" /></td>
				<td> <fmt:formatDate pattern="hh:mm a" value="${shift.assignedSignIn}" /></td>
				<td> <fmt:formatDate pattern="hh:mm a" value="${shift.assignedSignOut}" /></td>
				<td> <fmt:formatDate pattern="hh:mm a" value="${shift.signIn}" /></td>
				<td> <fmt:formatDate pattern="hh:mm a" value="${shift.signOut}" /></td>
			</tr>
	</c:forEach>
	</c:otherwise>
	</c:choose>

</tbody>
</table>
</div>
<div class="text-right">
    <a class="aniLink" href="/employers/dashboard">dashboard</a>
</div>



</body>
</html>
