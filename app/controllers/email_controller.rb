class EmailController < ApplicationController
  
  before_filter :fetch_logged_user

  def fetch_logged_user
    if session[:user_id].blank? then
      redirect_to :controller => "login", :action => "index"
    else
      @user = User.find(session[:user_id])
      if not @user.admin? then
        flash[:error] = "Sie haben nicht das Recht dafür!"
        redirect_to :action => "index", :controller => "home"
      end
    end
  end
  
  def username
    @titel = "Soll dem Benutzer eine Kennung gesendet werden?"
    if not flash[:results]then
      flash[:error] = "Daten abgelaufen! <br /> Verwenden sie nicht den Zurück Knopf!"
      redirect_to :controller => "home", :action => "index"
      return false
    end
    
    if not flash[:results][params[:id].to_i]["email"]then
      flash[:error] = "Der Benutzer hat keine Mailadresse hinterlegt :("
      redirect_to :controller => "home", :action => "index"
      return false
    end    
    
    if params[:submit] then
      Emailer.deliver_username(flash[:results][params[:id].to_i]["username"],flash[:results][params[:id].to_i]["email"],@user.sig, flash[:instants].url)
      flash[:notice] = "Die Mail wurde versendet :)"
      redirect_to :controller => "home", :action => "index"
      return false
    end
    
    flash.keep(:results)
    flash.keep(:permission)
    flash.keep(:instants)
        
  end
end
