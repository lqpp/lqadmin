class SucheController < ApplicationController
  before_filter :fetch_logged_user

  def fetch_logged_user
    if session[:user_id].blank? then
      redirect_to :controller => "user", :action => "login"
    else
      @user = User.find(session[:user_id])
    end
  end
  
  
  def index
    @titel    = "Suche:"
    @instants = Instants.find_by_sql("select * from instants, (select instants_id as id from permissions where user_id = #{@user.id} ) as perm where instants.id = perm.id")
  end
  
  def by_invite
    @instants  = Instants.find(params["id"])
    suche     = Suche.new(@user, @instants)
    permission= suche.get_user_permissions
    
    @titel    = "Suchen nache einem Invete-Code in <u>#{@instants.title}</u>"
    
    if not permission.check_invite_status and not permission.check_invite_username and not permission.check_invite_userid then
      flash[:error] = "Sie haben nicht das Recht nach einem Invite-Code in <u>#{@instants.title}</u> zu suchen!"
      redirect_to :action => "index"
    end
    
    if params["such"] then
      result = suche.invite params["such"]
      
      if result.nil? then
        flash[:notice] = "Den Invite-Code gibt es nicht :("
        redirect_to 
      else
        flash[:result_id] = result[:userid]
      
        @show = {}
      
        if permission.check_invite_status then
          @show[:status] = result[:status]
        end
        
        if permission.check_invite_username then
          @show[:username] = result[:username]
        end
        
        if permission.check_invite_userid then
          @show[:userid] = result[:userid]
        end
        
      end
    end
    
  end

end

