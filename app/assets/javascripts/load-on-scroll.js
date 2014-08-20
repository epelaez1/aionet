$(function  () {
	var lastTweetId = $('.tweet').last().attr('id');
	$('#end').waypoint(function(direction){

		$.ajax('http://aionet.herokuapp.com/zones/moreTweets?last_tweet=' + lastTweetId ).done(function(data){
			for (var i = 1; i < data.length; i++) {
				if (data[i].retweeted_status){  					
					$('<div class="tweet" id=' + data[i].id_str + ' ><div class="retweeter">@' + data[i].user.screen_name + ' retweetted</div><div class="tweetImageBox"><img alt="Csakqgwk normal" class="tweetImage" src=' + data[i].retweeted_status.user.profile_image_url + '></div><div class="tweetBody"><div class="tweetAuthor">' + data[i].retweeted_status.user.name + '<div class="username">@' + data[i].retweeted_status.user.screen_name + '</div></div><div class="tweetBodyText">' + data[i].retweeted_status.text + '</div></div><div class="tweetFooter"></div></div><hr>').insertBefore($("#end"));
				}
				else {
					$('<div class="tweet" id=' + data[i].id_str + '><div class="tweetImageBox"><img alt="Csakqgwk normal" class="tweetImage" src=' + data[i].user.profile_image_url + '></div><div class="tweetBody"><div class="tweetAuthor">' + data[i].user.name + '<div class="username"> @' + data[i].user.screen_name + '</div></div><div class="tweetBodyText">' + data[i].text + '</div></div><div class="tweetFooter"></div></div><hr>').insertBefore($("#end"));
				};
			};
		});
	});
});


