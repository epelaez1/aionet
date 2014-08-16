class OmniauthCallbacksController < Devise::OmniauthCallbacksController   
    def twitter
      auth = env["omniauth.auth"]
      binding.pry
      
    end
end