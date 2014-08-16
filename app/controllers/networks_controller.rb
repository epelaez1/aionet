class NetworksController < ApplicationController
	before_action :authenticate_user!
	layout 'networks'
end
