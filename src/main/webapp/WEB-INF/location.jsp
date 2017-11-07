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
	
	<div class="top">
	<div class="col-md-4 col-md-offset-6 logo">
	<img src="/img/logo_grey2.png" class="logoImg"></div>
	</div>

<div class="col-md-4 col-md-offset-6 middleForm">


 <form action="/employers/createLocation" method="post" class="form-group"> 
 <h1> Add A Location</h1>
	<p> <input type="text" name="name" class="form-control" placeholder="Name of the location"/> </p>
    
    <p><input id="address" name="address" type="text" placeholder="Enter address here" class="form-control"/></p>
    <p> <button id="btn" type="button" class="btn btn-secondary btn-block">Get LatLong</button></p>
    <div>
        <p>Latitude:
            <input type="text" id="latitude" name="latitude" readonly />
        </p>
        <p>Longitude:
            <input type="text" id="longitude" name="longitude" readonly/>
        </p>
		 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <input type="submit" value="submit" class="btn btn-block btn-info">
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