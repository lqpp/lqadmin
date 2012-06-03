class UserController < ApplicationController
  def login
    if params[:email]
      user = User.authenticate(params[:email],params[:pass])
      if user.nil? then
        @error = "Menutzername oder Passowrd falsch";
      else
        redirect_to :controller => "home", :action => "index" 
      end
    end
  end
end
