class ZonesController < ApplicationController
	before_action :authenticate_user!
	layout 'zone'
	
	def new 
		@newzone = User.find(current_user.id).zones.new
		@zonesUserCanAdd = zonesUserHasnt
	end
	def create
		if !hasUserThisZone?(params[:zone]) && paramPermited?
			addZoneToUser
			redirect_to root_path
			return
		else
			redirect_to new_zone_path
			return
		end
	end

	private
	def hasUserThisZone?(zone)
		User.find(current_user.id).zones.find_by(:zone => zone)
	end
	
	def allZones
		allzones = ["social"]
	end
	
	
	def addZoneToUser
		addzone = User.find(current_user.id).zones.new :zone => params[:zone]
		addzone.save
	end

	def paramPermited?
		params[:zone] == "social"
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
