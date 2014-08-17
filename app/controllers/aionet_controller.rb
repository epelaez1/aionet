class AionetController < ApplicationController
	before_action :authenticate_user!
	def index
		
		if !hasUserZones?
			redirect_to new_zone_path
			return
		end
		
		zones = zonesUserHas
		redirect_to zones_path(:zone => zones.first)
	end

	private

	
	def hasUserZones?
		current_user.zones != []
	end
end