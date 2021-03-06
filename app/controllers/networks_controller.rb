class NetworksController < ApplicationController
	before_action :authenticate_user!
	layout 'networks'
	def index
		if params[:networks]
			redirect_to "/networks/#{params[:network]}"
		else
			redirect_to root_path
		end
	end

	def new
		if !params[:zone]
			redirect_to root_path
			return
		end 
		if hasUserThisZone?(params[:zone])
			@currentZone = params[:zone]
			@networksToAdd = networksUserHasntAt(params[:zone])
			render 'new', :layout => 'newzone'
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