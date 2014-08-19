class HomeController < ApplicationController

def index
	
	logged_user_id = current_user.id
	logged_user = User.find(logged_user_id)
	
		 # twitter_token = User.find(logged_user_id).networks.find_by(network: 'twitter').network_token
		 # twitter_verifier = User.find(logged_user_id).networks.find_by(network: 'twitter').network_verifier
		# status_string = Net::HTTP.get(URI.parse("https://api.twitter.com/1.1/statuses/home_timeline.json/#{username}.xml?callback=twitterCallback2&count=#{how_many}"))
		@client = Twitter::REST::Client.new do |config|
	      config.consumer_key        = ENV['TWITTER_KEY']
	      config.consumer_secret     = ENV['TWITTER_SECRET_KEY']
	      config.access_token        = ENV['TWITTER_TOKEN']
	  	  config.access_token_secret = ENV['TWITTER_SECRET_TOKEN']
    	end
  #   	def prepare_access_token(oauth_token, oauth_token_secret)
		#   consumer = OAuth::Consumer.new( ENV['TWITTER_KEY'], ENV['TWITTER_SECRET_KEY'],
		#     { :site => "https://api.twitter.com",
		#       :scheme => :header
		#     })
		#   # now create the access token object from passed values
		#   token_hash = { :oauth_token => oauth_token,
		#                  :oauth_token_secret => oauth_token_secret
		#                }
		#   access_token = OAuth::AccessToken.from_hash(consumer, token_hash )
		#   return access_token
		# end
 
		# # Exchange our oauth_token and oauth_token secret for the AccessToken instance.
		# access_token = prepare_access_token(ENV['TWITTER_TOKEN'], ENV['TWITTER_SECRET_TOKEN'])
		# # use the access token as an agent to get the home timeline
		# response = access_token.request(:get, "https://api.twitter.com/1.1/statuses/home_timeline.json")
    render 'index'

end

end
