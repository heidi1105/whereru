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
    
    <meta charset="utf-8">
    <title>Places Searchbox</title>
    <script
    src="https://code.jquery.com/jquery-3.2.1.js"
    integrity="sha256-DZAnKJ/6XZ9si04Hgrsxu/8s717jcIzLy3oi35EouyE="
    crossorigin="anonymous"></script>
    
    
   <body>
<h1 class="jumbotron"> Where R U? ${currentUser.firstname} ${currentUser.lastname} </h1>




<div>
<p> Name: ${shift.get(0).location.name} | Address: ${shift.get(0).location.address} 
| Date: <fmt:formatDate pattern="MM/dd/yyyy" value="${shift.get(0).assignedDate}" />
| Shift: <fmt:formatDate pattern="hh:mm a" value="${shift.get(0).assignedSignIn}" /> ~ <fmt:formatDate pattern="hh:mm a" value="${shift.get(0).assignedSignOut}" /> </p>
<button class="pure-button button btn btn-success btn-block">Get my location</button>
 <form action="/employees/sign/${shift.get(0).id}">
        <p>Latitude:<input type="text" id="latitude" name="latitude" readonly />
			Longitude: <input type="text" id="longitude" name="longitude" readonly />
        </p>
<input type="hidden" value="${currentUser.id}" name="currentUser"> 
<c:choose>
	<c:when test="${shift.get(0).signIn ==null}">
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
<script type="text/javascript">
    /** NOTE: uses jQuery for quick & easy DOM manipulation **/

    function getLocation(){
      var msg; 

      if('geolocation' in navigator){
        requestLocation();
      }else{
        msg = "Sorry, looks like your browser doesn't support geolocation";
        outputResult(msg); 
      }

      function requestLocation(){
        navigator.geolocation.getCurrentPosition(success); 
        
        function success(pos){
        
         
          var lng = pos.coords.longitude;
          var lat = pos.coords.latitude;
          
          msg = 'You appear to be at longitude: ' + lng + ' and latitude: ' + lat;

  	    	document.getElementById('latitude').value = lat;
	    	document.getElementById('longitude').value = lng;


        }
        
        
  
        function error(err){

          msg = 'Error: ' + err + ' :(';
          outputResult(msg); // output button
          $('.pure-button').removeClass('pure-button-primary').addClass('pure-button-error'); // change button style
        }  
      } 


      function outputResult(msg){
        $('.result').addClass('result').html(msg);
      }
    } 


    $('.pure-button').on('click', function(){

   /*    $('.result').html('<i class="fa fa-spinner fa-spin"></i>'); */
      getLocation();
    });
    </script>

    <form id="logoutForm" method="POST" action="/logout">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <button class="btn btn-danger btn-block" type="submit"> Logout</button>
    </form>


  </body>
</html>