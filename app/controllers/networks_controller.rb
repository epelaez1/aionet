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
			@networksToAdd = networksUserHastnAt(params[:zone])
			render 'new'
			return
		else
			redirect_to root_path
			return
		end
	end
	def hasUserThisZone?(zone)
		current_user.zones.find_by(:zone => zone)
	end
	
	def networksOf(zone)
		allNetworks[zone]
	end
	
	
	def networksUserHastnAt(zone)
		networksreturned = 	networksOf(zone) - networksUserHasAt(zone)
	end
end
