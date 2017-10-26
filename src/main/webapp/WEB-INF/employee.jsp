<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Employee Dashboard</title>
<link rel="stylesheet" type="text/css" href="/css/bootstrap.css">
</head>
<body>
<h1 class="jumbotron">  Dashboard</h1>

<div class="container">
    <form id="logoutForm" method="POST" action="/logout">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <button class="btn btn-warning" type="submit"> Logout</button>
    </form>
<h1>Welcome ${currentUser}</h1>

<table class="table table-hover table-striped">
<thead>
	<tr>
		<th> Location  </th>
		<th> Shift Date </th>
		<th> Shift Time In </th>
		<th> SHift Time Out </th>
		<th> Actions </th>
	</tr>
</thead>
<tbody>
	<c:forEach var="shift" items="${shifts}">
	<tr>
		<td> @{shift.location.name} </td>
		<td> ${shift.assignedDate }</td>
		<td> ${shift.signin}</td>
		<td> ${shift.signout}</td>
		<td><a class="btn btn-success" href="/employee/signin/${shift.id}"> Sign In </a> |
		<a class="btn btn-danger" href="/employee/signout/${shift.id}"> Sign Out </a>
		</td>
	</tr>
	</c:forEach>

</tbody>


</table>

</body>
</html>