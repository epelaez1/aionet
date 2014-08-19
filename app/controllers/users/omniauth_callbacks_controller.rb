class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # def facebook
  #   # You need to implement the method below in your model (e.g. app/models/user.rb)
  #   @user = User.from_omniauth(request.env["omniauth.auth"])

  #   if @user.persisted?
  #     sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
  #     set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
  #   else
  #     session["devise.facebook_data"] = request.env["omniauth.auth"]
  #     redirect_to new_user_registration_url
  #   end
  # end
  def twitter
      binding.pry
      user_logged = User.find(current_user.id)
      token = params[:oauth_token]
      verifier = params[:oauth_verifier]
      add_twitter_network = user_logged.networks.new(:network => 'twitter', :category => 'social', :network_token => token, :network_verifier => verifier)
      
      if add_twitter_network.save

        flash[:notice] = "Twitter Added to your networks"
        redirect_to '/'
      else
        flash[:notice] = "Doesn't added to your nerworks"
        redirect_to '/project/1/'
      end
  end
end