class NetworksController < ApplicationController
	before_action :authenticate_user!
	layout 'networks'
	def index
		redirect_to "/networks/#{params[:network]}"
	end

	def new
		if !params[:zone]
			redirect_to root_path
			return
		end 
		if hasUserThisZone?(params[:zone])
			@currentZone = params[:zone]
			@networksToAdd = networksUserHasntAt(params[:zone])
			render 'new'
			return
		else
			redirect_to root_path
			return
		end
	end
	def twitter
		redirect_to root_path
	end

	
	
end
