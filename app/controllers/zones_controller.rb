class ZonesController < ApplicationController
	def new 
		@newzone = User.find(current_user.id).zones.new

	end
	def create
		if !hasUserThisZone? && paramPermited?
			addZoneToUser
		else
			redirect_to new_zone_path
			return
		end
		binding.pry
		redirect_to root_path
	end
	def hasUserThisZone?
		User.find(current_user.id).zones.find_by(:zone => params[:zone])
	end
	def addZoneToUser
		@addzone = User.find(current_user.id).zones.new :zone => params[:zone]
		@addzone.save

	end
	def paramPermited?
		params[:zone] == "social"
	end
end
