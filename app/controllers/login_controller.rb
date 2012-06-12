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
  
  def update
    if params[:register] then
      @user = User.authenticate(params[:email],params[:register])
      if not @user then
        flash[:error] = "Der Link ist nicht mehr gültig!"
        redirect_to :controller => "login", :action => "index"
      end
      @register = params[:register]
    else if session[:user_id].blank? then
        redirect_to :controller => "login", :action => "index"
        return
      end
      @user = User.find(session[:user_id])
    end
    
    if params[:old]
      if params[:new] != params[:new2]
        @error = "Die Passwordwiederholung ist falsch"
      elsif params[:new].length < 8 then
        @error = "Ihr Password ist zu kurz" 
      elsif @user.update_pass(params[:old],params[:new]) then
         flash[:notice] = "Password wurde geändert"
         redirect_to :controller => "home", :action => "index"
         return
       else
         @error = "Ihr altes Password ist falsch"
      end
    end    
    @user = false if params[:register]
  end
  
end
