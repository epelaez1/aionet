class AionetController < ApplicationController
	before_action :authenticate_user!
	def index
		@userzones = current_user.zones
		
		if @userzones == []
			redirect_to new_zone_path
			return
		end
		
		zones = eachZone
		redirect_to "/zones?zone=#{zones.first}"
	end

	private

	def eachZone
		returnedzones = []
		@userzones.each do |databaseZoneRow|
			returnedzones << databaseZoneRow.zone
		end
		returnedzones
	end
end