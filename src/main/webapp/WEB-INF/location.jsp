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
	
<!-- <script type="text/javascript">
/* 	$(document).ready(function(){
		$(document).on("click", "#location", function(){
			var address = ($(this).attr('value'));
			var addy = address.replaceAll("\\s","");
			var url = "https://maps.googleapis.com/maps/api/geocode/json?address="+ addy + "&key=AIzaSyA6GV4vn8fPfAwYa1BHw1yYeygwSFXW5tQ";
			$.get(url, function(data){
				
			})
		})
	}) */
	
/*  	function codeAddress(){
		var address = document.getElementById('address').value;
		
		geocoder.geocode({'address': address}, function(results,status){
			if(status == google.maps.GeocoderStatus.OK){
				var latitude = results[0].geometry.location.lat();
				var longitude = results[0].geometry.locaton.lng();
				document.getElementById('long').innerHTML = longitude;
				document.getElementById('lat').innerHTML = latitude;
				$.ajax({
					url:"/process/addLocationInfo?=lng" + longitude + "&lat=" + latitude;
					method: 'GET'
				})
				
			}
			else{
				alert('Geocode was not successful for the following reason: ' + status);
			}
		})
	}  */
</script> -->
<%-- 
<fieldset>
<legend> Add Location </legend>
<form action="/employers/addLocation" method="Post">
	<p><label>Name:</label>
		<input type="text" name="name"/>
	</p>
	<p><label> Address:</label>
		<input id="address" type="text" id="address" name="address"/>
	</p>
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<button class="btn btn-success" type="submit"> Add a location </button>
</form> 
</fieldset>
</div> --%>

<div>
     <h3> Enter an address and press the button</h3>

    <input id="address" type="text" placeholder="Enter address here" />
    <button id="btn">Get LatLong</button>
    <div>
        <p>Latitude:
            <input type="text" id="latitude" readonly />
        </p>
        <p>Longitude:
            <input type="text" id="longitude" readonly />
        </p>
    </div>
</div>
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&key=AIzaSyA6GV4vn8fPfAwYa1BHw1yYeygwSFXW5tQ"></script>
<script type="text/javascript">
	
	function showResult(result) {
	    document.getElementById('latitude').value = result.geometry.location.lat();
	    document.getElementById('longitude').value = result.geometry.location.lng();
	}

	function getLatitudeLongitude(callback, address) {
	    // If adress is not supplied, use default value 'Ferrol, Galicia, Spain'
	    address = address || 'Ferrol, Galicia, Spain';
	    // Initialize the Geocoder
	    geocoder = new google.maps.Geocoder();
	    if (geocoder) {
	        geocoder.geocode({
	            'address': address
	        }, function (results, status) {
	            if (status == google.maps.GeocoderStatus.OK) {
	                callback(results[0]);
	            }
	        });
	    }
	}
	var el = document.getElementById('btn')
	var button = document.getElementById('btn');

	button.addEventListener("click", function () {
	    var address = document.getElementById('address').value;
	    getLatitudeLongitude(showResult, address)
	});

	</script>
</body>
</html>