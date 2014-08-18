class OmniauthCallbacksController < Devise::OmniauthCallbacksController   
    def google_oauth2
    	auth = env["omniauth.auth"]
    	binding.pry
    	@authjson = auth.to_json
    	render 'zones/auth', :layout => 'empty'
    end
    def twitter
      	auth = env["omniauth.auth"]
      
		network = "twitter"
		networkUserId = auth.extra["access_token"].params[:user_id]
		networkUserName = auth.extra["access_token"].params[:screen_name]
		token = auth.extra["access_token"].params[:oauth_token]
		secretToken = auth.extra["access_token"].params[:oauth_token_secret]
		  
		addTwitter = current_user.zones.find_by(:zone => "social").networks.new(:network => network , :network_user_id => networkUserId, :network_user_name => networkUserName, :token => token, :secret_token => secretToken)
	  	
	  	if addTwitter.save
	  		redirect_to zones_path(:zone => "social")
			return
		else
			redirect_to root_path
			return
		end
    end
end