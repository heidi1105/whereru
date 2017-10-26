<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <title>Places Searchbox</title>
    <script
    src="https://code.jquery.com/jquery-3.2.1.js"
    integrity="sha256-DZAnKJ/6XZ9si04Hgrsxu/8s717jcIzLy3oi35EouyE="
    crossorigin="anonymous"></script>
    
    
   <body>
<h1>A super-simple geolocatio&#8203;n example</h1>
<i class="fa fa-map-marker"></i>
<button class="pure-button pure-button-primary">Get my location</button>
<div class="result"></div>
<script type="text/javascript">
    /** NOTE: uses jQuery for quick & easy DOM manipulation **/

    function getLocation(){
      var msg; 

      /** 
      first, test for feature support
      **/
      if('geolocation' in navigator){
        // geolocation is supported :)
        requestLocation();
      }else{
        // no geolocation :(
        msg = "Sorry, looks like your browser doesn't support geolocation";
        outputResult(msg); // output error message
        $('.pure-button').removeClass('pure-button-primary').addClass('pure-button-success'); // change button style
      }

      /*** 
      requestLocation() returns a message, either the users coordinates, or an error message
      **/
      function requestLocation(){
        /**
        getCurrentPosition() below accepts 3 arguments:
        a success callback (required), an error callback  (optional), and a set of options (optional)
        **/
      
        var options = {
          // enableHighAccuracy = should the device take extra time or power to return a really accurate result, or should it give you the quick (but less accurate) answer?
          enableHighAccuracy: false,
          // timeout = how long does the device have, in milliseconds to return a result?
          timeout: 5000,
          // maximumAge = maximum age for a possible previously-cached position. 0 = must return the current position, not a prior cached position
          maximumAge: 0
        };
      
        // call getCurrentPosition()
        navigator.geolocation.getCurrentPosition(success, error, options); 
      
        // upon success, do this
        function success(pos){
          // get longitude and latitude from the position object passed in
          var lng = pos.coords.longitude;
          var lat = pos.coords.latitude;
          // and presto, we have the device's location!
          msg = 'You appear to be at longitude: ' + lng + ' and latitude: ' + lat  + '<img src="https://maps.googleapis.com/maps/api/staticmap?zoom=15&size=300x300&maptype=roadmap&markers=color:red%7Clabel:A%7C' + lat + ',' + lng+ '&sensor=false">';
          outputResult(msg); // output message

          $('.pure-button').removeClass('pure-button-primary').addClass('pure-button-success'); // change button style
          $.ajax({
  			url: "/process/signIn?lng=" + lng + "&lat=" + lat,
  			method: 'GET'
  		})
        }
        
        
        // upon error, do this
        function error(err){
          // return the error message
          msg = 'Error: ' + err + ' :(';
          outputResult(msg); // output button
          $('.pure-button').removeClass('pure-button-primary').addClass('pure-button-error'); // change button style
        }  
      } // end requestLocation();

      /*** 
      outputResult() inserts msg into the DOM  
      **/
      function outputResult(msg){
        $('.result').addClass('result').html(msg);
      }
    } // end getLocation()

    // attach getLocation() to button click
    $('.pure-button').on('click', function(){
      // show spinner while getlocation() does its thing
      $('.result').html('<i class="fa fa-spinner fa-spin"></i>');
      getLocation();
    });
    </script>

  </body>
</html>