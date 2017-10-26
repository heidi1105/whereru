<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="/css/bootstrap.css">
<title>Teachers</title>
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
		<th> Employee  </th>
		<th> Shift Date </th>
		<th> Shift Time In </th>
		<th> SHift Time Out </th>
		<th> Actions </th>
	</tr>
</thead>
<tbody>
	<c:forEach var="shift" items="${shifts}">
	<tr>
		<td> ${shift.employee.firstname} ${shift.employee.lastname } </td>
		<td> ${shift.assignedDate }</td>
		<td> ${shift.signin}</td>
		<td> ${shift.signout}</td>
		<a class="btn btn-success" href="/employers/edit/${shift.id}"> Edit </a>
		<a class="btn btn-danger" href="/employers/delete/${shift.id}"> Delete </a>
		</td>
	</tr>
	</c:forEach>

</tbody>


</table>




<p><form:errors class="errors" path="shift.*"/></p>
<fieldset>
<legend> Add Shift </legend>
<form:form action="/employers/addShift" method="post" modelAttribute="shift">
	<p><form:label path="employee"/>
		<form:select path="employee">
			<c:forEach items="${employees}" var="employee">
				<form:option value="${employee.id}">${employee.firstname} ${employee.lastname}</form:option>
			</c:forEach>
		</form:select>
	</p>
	<p><form:label path="Date"/>
		<form:input type="date" path="assignedDate"/>
	</p>
	<p><farm:label path="signin"/>
		<form:input path="signin" type="Date"/>
	</p>
	<p><farm:label path="signout"/>
		<form:input path="signout" type="Date"/>
	</p>	
	<p><form:label path="location"/>
		<form:select path="location">
			<c:forEach items="${locations}" var="location">
				<form:option value="${location.id}"> ${location.address}</form:option>
			</c:forEach>
		</form:select>
	</p>
	<form:hidden path="employer" value="${currentUser.id}"/>
<button class="btn btn-success" type="submit"> Create a Shift </button>
</form:form> 

</fieldset>

<a href="/employers/addLocation">Add Location</a>

</body>
</html>