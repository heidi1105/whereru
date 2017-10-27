<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <link rel="stylesheet" type="text/css" href="/css/bootstrap.css">
  
    
    <title>Shift SignIn/Out</title>
    <script
    src="https://code.jquery.com/jquery-3.2.1.js"
    integrity="sha256-DZAnKJ/6XZ9si04Hgrsxu/8s717jcIzLy3oi35EouyE="
    crossorigin="anonymous"></script>
    
      <script type="text/javascript" src="/js/currentLocation.js"></script>
   <body>
<h1 class="jumbotron"> Where R U? ${currentUser.firstname} ${currentUser.lastname} </h1>

<div>
 <p> Name: ${shift.location.name} | Address: ${shift.location.address} 
| Date: <fmt:formatDate pattern="MM/dd/yyyy" value="${shift.assignedDate}" />
| Shift: <fmt:formatDate pattern="hh:mm a" value="${shift.assignedSignIn}" /> ~ <fmt:formatDate pattern="hh:mm a" value="${shift.assignedSignOut}" /> </p>
<button class="pure-button button btn btn-success btn-block">Get my location</button>
  <form action="/employees/sign/${shift.id}">
        <p>Latitude:<input type="text" id="latitude" name="latitude" readonly />
			Longitude: <input type="text" id="longitude" name="longitude" readonly />
        </p>
<input type="hidden" value="${currentUser.id}" name="currentUser"> 
<c:choose>
	<c:when test="${shift.signIn ==null}">
	<button class="pure-button button btn btn-success btn-block" type="submit">Sign in</button>
	</c:when>
	<c:otherwise>
	<button class="pure-button button btn btn-success btn-block">Sign out</button>	
	</c:otherwise>
</c:choose>

</form> 
</div>

<i class="fa fa-map-marker"></i>

<div class="result"></div>
 <script type="text/javascript" src="/js/currentLocation.js"></script>

    <form id="logoutForm" method="POST" action="/logout">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <button class="btn btn-danger btn-block" type="submit"> Logout</button>
    </form>

  </body>
</html>