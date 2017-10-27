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
	<title>Employers</title>
</head>
<body>
<h1 class="jumbotron">  Dashboard</h1>

<div class="container">
    <form style="display:inline-block" id="logoutForm" method="POST" action="/logout">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <button class="btn btn-warning" type="submit"> Logout</button>
    </form>
    <a class="btn btn-info" href="/employers/previousShifts">Previous Shifts</a>
    <a class="btn btn-primary" href="/employers/addLocation">Add Location</a>
<h1>Welcome ${currentUser.firstname}</h1>
<table class="table table-hover table-striped">
<thead>
	<tr>
		<th> Employee  </th>
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
				<td> ${shift.employee.firstname} ${shift.employee.lastname } </td>
				<td> <fmt:formatDate pattern="MM/dd/yyyy" value="${shift.assignedDate}" /></td>
				<td> <fmt:formatDate pattern="hh:mm a" value="${shift.assignedSignIn}" /></td>
				<td> <fmt:formatDate pattern="hh:mm a" value="${shift.assignedSignOut}" /></td>
				<td> <fmt:formatDate pattern="hh:mm a" value="${shift.signIn}" /></td>
				<td> <fmt:formatDate pattern="hh:mm a" value="${shift.signOut}" /></td>
				<td>
					<a class="btn btn-success" href="/employers/edit/${shift.id}"> Edit </a>
					<a class="btn btn-danger" href="/employers/delete/${shift.id}"> Delete </a>
				</td>
			</tr>
		</c:if>
	</c:forEach>

</tbody>


</table>




<p><form:errors class="errors" path="shift.*"/></p>
<fieldset>
<legend> Add Shift </legend>
<form:form action="/employers/dashboard" method="post" modelAttribute="shift">
	<p><form:label path="employee"/>
		<form:select path="employee">
			<c:forEach items="${employees}" var="employee">
				<form:option value="${employee.id}">${employee.firstname} ${employee.lastname}</form:option>
			</c:forEach>
		</form:select>
	</p>
	<p>Assigned shift date
		<form:input type="date" path="assignedDate" min="<%=new Date()%>"/></p>
	<p> Assigned sign in time
		<form:input type="time" path="assignedSignIn" /> (hh:mm AM/PM)
	</p>
	<p> Assigned sign out time
			<form:input type="time" path="assignedSignOut" /> (hh:mm AM/PM)
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


</body>
</html>
