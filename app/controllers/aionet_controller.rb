class AionetController < ApplicationController
	before_action :authenticate_user!
	def index
		userLogedId = current_user.id
		@userzones = User.find(userLogedId).zones.all
		
		if @userzones == []
			redirect_to new_zone_path
			return
		end
		
		@zones = []
		@zones << eachzone


		render 'index'
	end

	private
	
	def eachzone
		@userzones.each do |databaseZoneRow|
			databaseZoneRow.zone
		end
	end
end