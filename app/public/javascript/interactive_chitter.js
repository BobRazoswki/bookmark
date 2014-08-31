$(document).ready(function() {
	$('.show_replies').on('click', function() {
		$(this).siblings().slideDown("slow");
	});
});


//$('.reply_container').slideDown("slow")


/*
	$(document).ready(function() {
	$('.show_replies').on('click', function() {
		console.log($(this).siblings());
		$('.reply_container').slideDown("slow");
	});
});

*/