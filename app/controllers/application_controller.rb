class ApplicationController < ActionController::Base
	before_filter :configure_permitted_parameters, if: :devise_controller?

	private

	def allNetworks 
	  	allnetworks = {"social" => ["twitter"], "email" => ["google_oauth2"]}
	end

	def allZones
		allzones = ["social", "email"]
	end
	
	def zonesUserHas
		returnedzones = []
		current_user.zones.each do |databaseZoneRow|
			returnedzones << databaseZoneRow.zone
		end
		returnedzones
	end

	def hasUserThisZone?(zone)
		current_user.zones.find_by(:zone => zone)
	end
	
	def networksUserHasAt(zone)
		networksreturned = []
		current_user.zones.find_by(:zone => zone).networks.each do |networkRow|
			networksreturned << networkRow.network
		end 	
		networksreturned
	end

	def networksOf(zone)
		allNetworks[zone]
	end
	
	
	def networksUserHasntAt(zone)
		networksreturned = 	networksOf(zone) - networksUserHasAt(zone)
	end


	protected
	

	def configure_permitted_parameters
		devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
		devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
		devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
	end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	
	
end
