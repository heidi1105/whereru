$(function(){
	console.log('Ready!');


	if ($('.regErr').text()!==""){
		$('.logForm').hide();
	}else{
		$('.regForm').hide();		
	}
	
	


	$('.logLink').click(function(){
		$('.regForm').slideUp();
		$('.logForm').slideDown();		

	})
	
	$('.regLink').click(function(){
		$('.logForm').slideUp();
		$('.regForm').slideDown();

	})
	
})