class ZonesController < ApplicationController
	def new 
		@newzone = User.find(current_user.id).zones.new

	end
end
