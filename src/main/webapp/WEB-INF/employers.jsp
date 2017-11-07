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



<h4> Upcoming Shifts</h4>
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
		<th> Actions </th>
	</tr>
</thead>
<tbody>

<c:choose>
	<c:when test="${shifts.size() ==0}">
		<tr>
		<td colspan="8">
		There is no upcoming shifts. You may add a new shift below </td>
		</tr>
	</c:when>

	<c:otherwise>
		<c:forEach var="shift" items="${shifts}">
			<tr>
				<td> ${shift.employee.firstname} ${shift.employee.lastname } </td>
				<td> ${shift.location.name }</td>
				<td> <fmt:formatDate pattern="MM/dd/yyyy" value="${shift.assignedDate}" /></td>
				<td> <fmt:formatDate pattern="hh:mm a" value="${shift.assignedSignIn}" /></td>
				
				<td><fmt:formatDate pattern="hh:mm a" value="${shift.assignedSignOut}" /></td>
				<td> <fmt:formatDate pattern="hh:mm a" value="${shift.signIn}" /></td>
				<td> <fmt:formatDate pattern="hh:mm a" value="${shift.signOut}" /></td>
				<td>
					<a href="/employers/edit/${shift.id}"> Edit </a> |
					<a href="/employers/delete/${shift.id}"> Delete </a>
				</td>
			</tr>

	</c:forEach>

	</c:otherwise>
</c:choose>
</tbody>


</table>
</div>
<div class="text-right">
    <a class="aniLink" href="/employers/previousShifts">Previous Shifts</a>
</div>


<p><form:errors class="errors" path="shift.*"/></p>
<fieldset>
<legend> Add Shift </legend>
<form:form action="/employers/dashboard" method="post" modelAttribute="shift" class="form-group">
	<p><form:label path="employee"/>
		<form:select path="employee" class="form-control">
			<c:forEach items="${employees}" var="employee">
				<form:option value="${employee.id}">${employee.firstname} ${employee.lastname}</form:option>
			</c:forEach>
		</form:select>
	</p>
	<p>Assigned shift date
		<form:input type="date" path="assignedDate" min="<%=new Date()%>" class="form-control"/></p>
	<p> Assigned sign in time (hh:mm AM/PM)
		<form:input type="time" path="assignedSignIn" class="form-control"/> 
	</p>
	<p> Assigned sign out time (hh:mm AM/PM)
			<form:input type="time" path="assignedSignOut" class="form-control"/> 
	</p>
	<p><form:label path="location"/>
		<form:select path="location" class="form-control">
			<c:forEach items="${locations}" var="location">
				<form:option value="${location.id}"> ${location.address}</form:option>
			</c:forEach>
		</form:select>    <a class="aniLink" href="/employers/addLocation">Add Location</a>
	</p>
	<form:hidden path="employer" value="${currentUser.id}"/>
<button class="btn patone-blue btn-block" type="submit"> Create a Shift </button>
</form:form> 
</fieldset>

</div>

</body>
</html>
