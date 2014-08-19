$(function  () {
	var lastTweetId = $('.tweet').last().attr('id');
	$('.tweet').last().on('click', function(){
		$.ajax('http://aionet.herokuapp.com/zones/moreTweets?last_tweet=' + lastTweetId );
	});
});