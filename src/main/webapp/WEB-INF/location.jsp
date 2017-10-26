<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container">
	<h1> Add A Location</h1>
	
	
	<p><form:errors class="errors" path="shift.*"/></p>
<fieldset>
<legend> Add Shift </legend>
<form:form action="/employers/addLocation" method="post" modelAttribute="location">
	<p><form:label path="name"/>
		<form:input type="text" path="name"/>
	</p>
	<p><form:label path="Address"/>
		<form:input type="text" path="address"/>
	</p>
<button class="btn btn-success" type="submit"> Add a location </button>
</form:form> 
</fieldset>
</div>
</body>
</html>