$(function(){
	console.log('Ready!');
	
	
	$('.button').show();
	$('.button').siblings().hide();
	$('.button').parent().siblings().hide();
	$('h4').hide();

	
	$('.button').click(function(){
	$('.button').siblings().fadeIn(5000);
	$('.button').parent().siblings().fadeIn(5000);		
	$('h4').fadeIn(5000);
	
	})

	
	
})