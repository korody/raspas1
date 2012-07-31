$(function(){
	$(".quote_author, .quote_poster, .quote_favouriters, .quote_poster_pic").tooltip({

		// position
		position: 'bottom center',

		// use the "slide" effect
		effect: 'slide',

		predelay: '200',

		delay: '200'
 
	// add dynamic plugin with optional configuration for bottom edge
	}).dynamic({ bottom: { direction: 'down' } });

	// select all desired input fields and attach tooltips to them
	$(".user_board :input").tooltip({

		tipClass: "tooltip_field",

		// place tooltip on the right edge
		position: "top center",

		// use the built-in fadeIn/fadeOut effect
		effect: "slide",

		// custom opacity setting
		opacity: 0.8

	});
});  
