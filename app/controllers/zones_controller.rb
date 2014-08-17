class ZonesController < ApplicationController
	before_action :authenticate_user!
	layout 'zone'

	def index
		if hasUserThisZone?(params[:zone])
			if hasUserNetworksAt?(params[:zone])
				@zonesToGo = allZones - zonesUserHasnt - [params[:zone]]
				@canUserAddNewZone = canUserAddNewZone?
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
		render 'social'
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
	def hasUserThisZone?(zone)
		current_user.zones.find_by(:zone => zone)
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
