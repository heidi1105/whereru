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
<title>Edit Shift</title>
<link rel="stylesheet" type="text/css" href="/css/bootstrap.css">
</head>
<body>
<div container="class">
	<p><form:errors class="errors" path="shift.*"/></p>
<fieldset>
<legend> Edit Shift </legend>
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
	<form:hidden path="employer" value="${shift.employer.id}"/>
	<form:hidden path="id" value="${shift.id}"/>
<button class="btn btn-success" type="submit"> Edit a Shift </button>
</form:form> 
</fieldset>


</div>
</body>
</html>