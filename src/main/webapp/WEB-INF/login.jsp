<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="/css/bootstrap.css">
<title>Insert title here</title>
</head>
<body>
<div class="container">

<div class="row">
<div class="col-lg-6">
<h1 class="jumbotron blue"> Login </h1>
<form method="POST" action="/login">
	<table class="table table-hovered">
	<tr> 
		<td> Email </td>
		<td> <input type="text" name="username"> </td> 
	</tr>
	
	<tr>
		<td> Password </td>
		<td> <input type="password" name="password"></td>
	</tr>
	
	<tr>	
		<td colspan=2> 
		 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		<button class="btn btn-warning"> Login! </button> </td>
	</tr>			
	</table>
</form>
     <c:if test="${logoutMessage != null}">
     <p>   <c:out value="${logoutMessage}" /></p>
    </c:if>
    <c:if test="${errorMessage != null}">
      <p>  <c:out value="${errorMessage}" /> </p>
    </c:if>

</div>

<div class="col-lg-6">	
<h1 class="jumbotron green"> Register </h1>
<form:form method="POST" action="/register" modelAttribute="regUser">
	<table class="table table-hovered">
	
	<tr> 
		<td> Email </td>
		<td> <form:input path="username" /> </td> 
	</tr>

	<tr> 
		<td> First Name </td>
		<td> <form:input path="firstname" /> </td> 
	</tr>

	<tr> 
		<td> Last Name </td>
		<td> <form:input path="lastname" /> </td> 
	</tr>

	<tr>
		<td> Select your role </td>
		<td> <select name="role"> 
		<option value="employer"> Employer </option>
		<option value="employee"> Employee </option>
		</select>
		
	<tr>
		<td> Password </td>
		<td> <form:password path="password" /></td>
	</tr>
	
	<tr>
		<td> Confirm Password </td>
		<td> <form:password path="pwdcfm" /></td>
	</tr>
	<tr>
		<td colspan=2> <button class="btn btn-warning"> Register! </button> </td>
	</tr>			
	</table>
</form:form>
	<p> <form:errors path="regUser.*" /> </p>	


</div>
</div>
</div>



</body>
</html>