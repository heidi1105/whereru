
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