class ZonesController < ApplicationController
	before_action :authenticate_user!
	layout 'zone'

	def index
		if hasUserThisZone?(params[:zone])
			if hasUserNetworksAt?(params[:zone])
				
				redirect_to "/zones/#{params[:zone]}"
				return
			else
				redirect_to new_network_path(:zone => params[:zone])
				return
			end	
		else
			redirect_to root_path
		end
	end
	def social
		
		if hasUserThisZone?("social")
			@zonesToGo = allZones - zonesUserHasnt - ["social"]
			@canUserAddNewZone = canUserAddNewZone?	
			@currentZone = "social"
			client = Twitter::REST::Client.new do |config|
		      config.consumer_key        = ENV['TWITTER_KEY']
		      config.consumer_secret     = ENV['TWITTER_SECRET_KEY']
		      config.access_token        = current_user.zones.find_by(:zone => "social").networks.find_by(:network => "twitter").token
		  	  config.access_token_secret = current_user.zones.find_by(:zone => "social").networks.find_by(:network => "twitter").secret_token
	    	end
	    	@timeline = client.home_timeline(:count => 100)
	    	@mentions_timeline = client.mentions_timeline(:count => 100)
			@networksUserCanGo = networksUserHasAt("social")
			@networksUserCanAdd = networksUserHasntAt("social")
			render 'social'
			return
		else
			redirect_to root_path
			return
		end
	end
	def loadMoreTweets
		@client = Twitter::REST::Client.new do |config|
	      config.consumer_key        = ENV['TWITTER_KEY']
	      config.consumer_secret     = ENV['TWITTER_SECRET_KEY']
	      config.access_token        = current_user.zones.find_by(:zone => "social").networks.find_by(:network => "twitter").token
	  	  config.access_token_secret = current_user.zones.find_by(:zone => "social").networks.find_by(:network => "twitter").secret_token
	    end		

		lastTweetId = params[:last_tweet]
		render :json => @client.home_timeline(:max_id => lastTweetId).take(50)

	end
	def sendtweet
		@client = Twitter::REST::Client.new do |config|
	      config.consumer_key        = ENV['TWITTER_KEY']
	      config.consumer_secret     = ENV['TWITTER_SECRET_KEY']
	      config.access_token        = current_user.zones.find_by(:zone => "social").networks.find_by(:network => "twitter").token
	  	  config.access_token_secret = current_user.zones.find_by(:zone => "social").networks.find_by(:network => "twitter").secret_token
	    end	
	    asdf = {"data" => "ASDASDASD"}
		binding.pry
		params[:tweet]
	end
	def new
		if canUserAddNewZone?
			@newzone = current_user.zones.new
			@zonesUserCanAdd = zonesUserHasnt
			render :layout => 'newzone'
			return
		else
			redirect_to zones_path
		end
	end
	def create
		if !hasUserThisZone?(params[:zone]) && isThisAZone?(params[:zone])
			addZoneToUser(params[:zone])
			redirect_to zones_path(:zone => params[:zone])
			return
		else
			redirect_to new_zone_path
			return
		end
	end

	private
	def hasUserNetworksAt?(zone)
		current_user.zones.find_by(:zone => zone).networks != []
	end
	def canUserAddNewZone?
		zonesUserHasnt.count != 0
	end	
	
	def addZoneToUser(zone)
		addzone = current_user.zones.new :zone => zone
		addzone.save
	end

	def isThisAZone?(zone)
		allZones.include?(zone)
	end
	
	def zonesUserHasnt
		zonesreturned = []
		allZones.each do |zone|
			if !hasUserThisZone?(zone)
					zonesreturned << zone
			end
		end
		zonesreturned
	end
end