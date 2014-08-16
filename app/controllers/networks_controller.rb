class NetworksController < ApplicationController
	before_action :authenticate_user!
	layout 'networks'
	
	allNetworks = {"social" => ["facebook","twitter"]}
	currentZone = params[:zone]
	networksOfCurrentZone = allnetworks[currentZone]
	
	def new
		if hasUserThisZone
			@networksToAdd = networksUserHastn
			render 'new'
		else
			redirect_to root_path
		end
	end
	def hasUserThisZone?(zone)
		current_user.zones.find_by(:zone => currentZone)
	end

	def networksUserHas
		networksreturned = []
		current_user.zones.find_by(:zone => currentZone).networks.find_by(:network => network).each do |network|
			networksreturned << network
		end 	
		networksreturned
	end
	
	def networksUserHastn
		networksreturned = NetworksOfCurrentZone - networksUserHas
	end
end
