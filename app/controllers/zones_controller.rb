class ZonesController < ApplicationController
	before_action :authenticate_user!
	layout 'zone'
	def index
		if hasUserThisZone?(params[:zone])
			render params[:zone]
		else
			redirect_to root_path
		end
	end
	def new 
		@newzone = current_user.zones.new
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
		current_user.zones.find_by(:zone => zone)
	end
	
	def allZones
		allzones = ["social"]
	end
	
	
	def addZoneToUser
		addzone = current_user.zones.new :zone => params[:zone]
		addzone.save
	end

	def paramPermited?
		allZones.include?(params[:zone])
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
