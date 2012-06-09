class HomeController < ApplicationController
  
  before_filter :fetch_logged_user
  def fetch_logged_user
    if session[:user_id].blank? then
      redirect_to :controller => "login", :action => "index"
    else
      @user = User.find(session[:user_id])
    end
  end
  
  def index
    @titel = "Wilkommen im Admin-Interface von LQFB"
  end
end
