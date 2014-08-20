$(function  () {
	var lastTweetId = $('.tweet').last().attr('id');
	$('.tweet').last().on('click', function(){

		$.ajax('http://aionet.herokuapp.com/zones/moreTweets?last_tweet=' + lastTweetId ).done(function(data){
			console.log(data);
			for (var i = 0; i < data.length; i++) {
				console.log(data[i].text);
			};
		});
	});
});

