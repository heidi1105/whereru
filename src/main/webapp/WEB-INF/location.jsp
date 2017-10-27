<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="/css/bootstrap.css">
<title>Add a Location</title>

</head>
<body>
<div class="container">
	<h1> Add A Location</h1>


<div>

 <form action="/employers/createLocation" method="post"> 
	<p> Name of the location <input type="text" name="name" /> </p>
    
    <input id="address" name="address" type="text" placeholder="Enter address here" />
    <button id="btn" type="button">Get LatLong</button>
    <div>
        <p>Latitude:
            <input type="text" id="latitude" name="latitude" readonly />
        </p>
        <p>Longitude:
            <input type="text" id="longitude" name="longitude" readonly />
        </p>
		 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <input type="submit" value="submit">
</div>
</form>	
<a href="/employers/dashboard">Go Back</a>
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
	var b = document.getElementById('btn');

	b.addEventListener("click", function () {
	    var address = document.getElementById('address').value;
	    getLatitudeLongitude(showResult, address)
	});

	</script>
</body>
</html>