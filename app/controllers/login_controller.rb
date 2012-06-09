class LoginController < ApplicationController
  def index
    if params[:email]
      user = User.authenticate(params[:email],params[:pass])
      if user.nil? then
        flash[:error] = "Benutzername oder Passowrd falsch"
        redirect_to :controller => "login", :action => "index"
      else
        session[:user_id] = user.id
        redirect_to :controller => "home", :action => "index" 
      end
    end
  end
  
  def logout
    reset_session
    redirect_to :action => "index"
  end
end
