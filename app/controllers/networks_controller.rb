class NetworksController < ApplicationController
	before_action :authenticate_user!
	layout 'networks'
		
	def new
		if !params[:zone]
			redirect_to root_path
			return
		end 
		if hasUserThisZone?(params[:zone])
			@currentZone = params[:zone]
			@networksToAdd = networksUserHastn
			render 'new'
			return
		else
			redirect_to root_path
			return
		end
	end
	def hasUserThisZone?(zone)
		current_user.zones.find_by(:zone => params[:zone])
	end
	def allNetworks 
	  	allnetworks = {"social" => ["twitter"]}
	end
	def networksOfCurrentZone
		allNetworks[params[:zone]]
	end
	def networksUserHas
		networksreturned = []
		current_user.zones.find_by(:zone => params[:zone]).networks.each do |networkRow|
			networksreturned << networkRow.network
		end 	
		networksreturned
	end
	
	def networksUserHastn
		networksreturned = 	networksOfCurrentZone - networksUserHas
	end
end
