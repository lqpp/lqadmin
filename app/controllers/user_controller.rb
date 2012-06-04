class UserController < ApplicationController
  def login
    if params[:email]
      user = User.authenticate(params[:email],params[:pass])
      if user.nil? then
        flash[:error] = "Benutzername oder Passowrd falsch"
        redirect_to :controller => "user", :action => "login"
      else
        session[:user_id] = user.id
        redirect_to :controller => "home", :action => "index" 
      end
    end
  end
end
