<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add a Location</title>
</head>
<body>
<div class="container">
	<h1> Add A Location</h1>
<p id="long"></p>
<p id="lat"></p>
<script>
	function codeAddress(){
		var address = document.getElementById('address').value;
		
		geocoder.geocode({'address': address}, function(results,status){
			if(status == google.maps.GeocoderStatus.OK){
				var latitude = results[0].geometry.location.lat();
				var longitude = results[0].geometry.locaton.lng();
				document.getElementById('long').innerHTML = longitude;
				document.getElementById('lat').innerHTML = latitude;
				
			}
			else{
				alert('Geocode was not successful for the following reason: ' + status);
			}
		})
	}
</script>

<fieldset>
<legend> Add Shift </legend>
<form action="/employers/addLocation" method="Post">
	<p><label>Name:</label>
		<input type="text" name="name"/>
	</p>
	<p><label> Address:</label>
		<input type="text" id="address" name="address"/>
	</p>
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<button class="btn btn-success" type="submit"> Add a location </button>
</form> 
</fieldset>
</div>

</body>
</html>