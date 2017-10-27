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


<div class="container">
    <form id="logoutForm" method="POST" action="/logout">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <button class="btn btn-warning" type="submit"> Logout</button>
    </form>
<h1 class="jumbotron">${currentUser.firstname} , You are a liar!!!!!!! Go back to your shift! Stop eating fries</h1>
<a href="/employees/dashboard" class="btn btn-block btn-warning"> Go back and try again</a>

<img src="/img/logo-no-background.png" alt="logo"/>


</body>
</html>