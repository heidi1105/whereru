<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="/css/logReg.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript" src="/js/logReg.js"></script>



<title>Login/Register</title>
</head>
<body>
<div class="container">

	<div class="col-md-4 col-md-offset-6 logo">
	<img src="/img/logo_grey.png" class="logoImg"></div>
	
	
	<div class="col-md-4 col-md-offset-6 logregForm">
	
	
	
	
	<div class="row">
	
	<div class="col-lg-6"> <a href="#" class="logLink btn btn-block"> Login </a> </div>
	<div class="col-lg-6"> <a href="#" class="regLink btn btn-block"> Registration </a> </div>
	</div>
	

	
	
	<div class="logForm">
	<form method="POST" action="/login" class="form-group">
			<p> <input type="text" name="username" class="form-control" placeholder="Email"> </p> 

			<p> <input type="password" name="password" class="form-control" placeholder="password"></p>

			 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			<button class="btn btn-warning btn-block" type="submit"> Login! </button> 

	</form>
	     <c:if test="${logoutMessage != null}">
	     <p>   <c:out value="${logoutMessage}" /></p>
	    </c:if>
	    <c:if test="${errorMessage != null}">
	      <p>  <c:out value="${errorMessage}" /> </p>
	    </c:if>
	
	</div>




	
	<div class="regForm">
	<form:form method="POST" action="/register" modelAttribute="regUser" class="form-group">
	<div class="row roleChoice">
	<div class="col-lg-6">
  	 <input type="radio" name="role" value="employer" checked /> Employer </div>
  	 <div class="col-lg-6">
  	<input type="radio" name="role" value="employee" /> Employee </div>
  	</div>


		<p> <form:input path="username" placeholder="Email" class="form-control"/> </p> 
		<p> <form:input path="firstname" placeholder="First name" class="form-control"/> </p> 

			<p> <form:input path="lastname" placeholder="Last name" class="form-control"/> </p> 

			<p> <form:password path="password" placeholder="Password" class="form-control"/></p>

			<p> <form:password path="pwdcfm" placeholder="Confirm your passowrd" class="form-control"/></p>

			<p> <button class="btn btn-warning btn-block"> Register! </button> </p>

	</form:form>
		<p class="regErr"><form:errors path="regUser.*" class="err"/></p>	
	
	</div>

</div>




</div>



</body>
</html>