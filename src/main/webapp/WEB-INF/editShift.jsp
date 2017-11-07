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

	<div class="top">
	<div class="col-md-4 col-md-offset-6 logo">
	<img src="/img/logo_grey2.png" class="logoImg"></div>
	</div>

<div class="col-md-4 col-md-offset-6 middleForm">





<form:form action="/employers/dashboard" method="post" modelAttribute="shift" class="form-group">
<div class="form-row">
	<div class="col">
	<p> <form:label path="employee" class="control-label" for="employee"> Employee </form:label> </p>
	</div>
	<div class="col">
		<form:select path="employee" class="form-control" id="employee">
			<c:forEach items="${employees}" var="employee">
				<form:option value="${employee.id}">${employee.firstname} ${employee.lastname}</form:option>
			</c:forEach>
		</form:select>
	</div>
</div>
	
<div class="form-row">
	<div class="col-sm-6">		
	<p>	Assigned shift date</p>
	</div>
	<div class="col-sm-6">
	<p>	<form:input type="date" path="assignedDate" min="<%=new Date()%>" class="form-control"/></p>
	</div>
</div>	


<div class="form-row">
	<div class="col">
	<p>	Assigned sign in time (hh:mm AM/PM) </p>
		
	</div>
	<div class="col">
		<form:input type="time" path="assignedSignIn" class="form-control"/> 
	</div>
</div>

<div class="form-row">
	<div class="col">
<p>
		Assigned sign out time (hh:mm AM/PM)</p>
	</div>
	<div class="col">
		<form:input type="time" path="assignedSignOut" class="form-control"/> 
	</div>
</div>
	
<div class="form-row">
	<div class="col-sm-4">

<p>		Location</p>
	</div>
	<div class="col-sm-8">
		<p><form:select path="location" class="form-control">
			<c:forEach items="${locations}" var="location">
				<form:option value="${location.id}"> ${location.address}</form:option>
			</c:forEach>
		</form:select>
		</p>
	</div>
</div>
	
	
	
	<form:hidden path="employer" value="${shift.employer.id}"/>
	<form:hidden path="id" value="${shift.id}"/>
<button class="btn btn-block patone-blue" type="submit"> Edit a Shift </button>

</form:form> 

	<p><form:errors class="errors" path="shift.*"/></p>
<a href="/employers/dashboard"> Go Back</a>
</div>
</body>
</html>