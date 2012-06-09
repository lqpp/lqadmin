class SucheController < ApplicationController
  before_filter :fetch_logged_user

  def fetch_logged_user
    if session[:user_id].blank? then
      redirect_to :controller => "login", :action => "index"
    else
      @user = User.find(session[:user_id])
    end
  end
  
  
  def index
    @titel    = "Suche:"
    @instants = Instants.find_by_sql("select * from instants, (select instants_id as id from permissions where user_id = #{@user.id} ) as perm where instants.id = perm.id")
  end
  
  def invite
    @instants  = Instants.find(params["id"])
    suche     = Suche.new(@user, @instants)
    permission= suche.get_user_permissions
    
    @titel    = "Suchen nache einem Invete-Code in <u>#{@instants.title}</u>"
    
    if not permission.check_invite_status and not permission.check_invite_username and not permission.check_invite_userid then
      flash[:error] = "Sie haben nicht das Recht nach einem Invite-Code in <u>#{@instants.title}</u> zu suchen!"
      redirect_to :action => "index"
    end
    
    if params["such"] then
      reg = /^[a-zA-Z0-9@\s.,-]*$/
    
      if not reg.match(params["such"]) then
        flash[:error] = "Der Suchbegriff entspricht nicht den Richtlienien"
        redirect_to
      else
        result = suche.invite params["such"]
        
        if not result then
          flash[:notice] = "Den Invite-Code gibt es nicht :("
          redirect_to 
        else
          flash[:results]     = [ result ]
          flash[:permission]  = permission
        
          @show = {}
        
          if permission.check_invite_status then
            @show[:status] = result["status"]
          end        
          if permission.check_invite_username then
            @show[:username] = result["username"]
          end        
          if permission.check_invite_userid then
            @show[:userid] = result["userid"]
          end
          
        end
      end 
    end
  end # invite
  
  
  def fulltext
    @instants  = Instants.find(params["id"])
    suche     = Suche.new(@user, @instants)
    permission= suche.get_user_permissions
    
    @titel    = "Volltextsuche in <u>#{@instants.title}</u>"
    
    if not permission.search_fulltext_yesno and not permission.search_fulltext_username and not permission.search_fulltext_userid and not permission.search_fulltext_fulldetails then
      flash[:error] = "Sie haben nicht die Rechte für eine Volltextsuche in <u>#{@instants.title}</u>!"
      redirect_to :action => "index"
    end
    
    if params["such"] then
      reg = /^[a-zA-Z0-9@\s.,-]*$/
    
      if not reg.match(params["such"]) or params["such"].length < 4 then
        flash[:error] = "Der Suchbegriff entspricht nicht den Richtlienien"
        redirect_to
      else
        result = suche.fulltext params["such"]
        
        if result.count == 0 then
          flash[:notice] = "Es gibt keine Treffer"
          redirect_to 
        else
          if result.count > 50 then
            flash[:error] = "Die Trefferliste ist auf 50 begrenzt!"
            redirect_to
          else  
            
            flash[:results]     = result
            flash[:permission]  = permission
          
            @show = []
          
            result.each do |r|
              out = {}
              if permission.search_fulltext_username then
                out[:username] = r["username"]
              end        
              if permission.search_fulltext_userid then
                out[:userid] = r["userid"]
              end   
              if permission.search_fulltext_fulldetails then
                out[:fulldetails] = r
              end     
              @show << out    
            end
          end          
        end
      end      
    end
  end

end

