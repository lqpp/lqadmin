class Suche  
  
  
  def initialize(user, instants)
    
    @user     = user
    @instants = instants
    
    @permission = Permission.find_by_sql("select * from permissions where user_id = #{user.id} AND instants_id = #{instants.id}").first
    if @permission.nil? then
      if @user.accessall then
        @permission = Permission.new( 
          :search_fulltext_yesno => true, 
          :search_fulltext_username => true, 
          :search_fulltext_userid => true, 
          :search_fulltext_fulldetails => true, 
          :check_invite_status => true, 
          :check_invite_username => true, 
          :check_invite_userid => true, 
          :invitecode_sendusermail => true, 
          :username_sendfreetextemail => true, 
          :invitecode_disable => true, 
          :invitecode_create => true) 
      else
        @permission = Permission.new()  
      end
    end
  end
  
  def get_user_permissions
    return @permission
  end
  
  def fulltext (text)
    require 'pg'
    conn = PGconn.open(:dbname => @instants.dbname)    
          
    Log.create(:user_id => @user.id, :instants_id => @instants.id, :action => "search_fulltext", :parameters => text)
          
    return conn.exec(
"SELECT id as userid, login as username ,active, last_login, name, realname, email as pub_mail, notify_email as email, notify_email_unconfirmed FROM member where
login ~* '#{text}' OR
notify_email ~* '#{text}' OR
notify_email_unconfirmed ~* '#{text}' OR
notify_email_secret ~* '#{text}' OR
password_reset_secret ~* '#{text}' OR
name ~* '#{text}' OR
identification ~* '#{text}' OR
organizational_unit ~* '#{text}' OR
internal_posts ~* '#{text}' OR
realname ~* '#{text}' OR
address ~* '#{text}' OR
email ~* '#{text}' OR
xmpp_address ~* '#{text}' OR
website ~* '#{text}' OR
phone ~* '#{text}' OR
mobile_phone ~* '#{text}' OR
profession ~* '#{text}' OR
external_memberships ~* '#{text}' OR
external_posts ~* '#{text}' OR
statement ~* '#{text}'
").find_all.to_a
  end 
  
  
  def invite (code)
    require 'pg'
    conn = PGconn.open(:dbname => @instants.dbname)    
    
    Log.create(:user_id => @user.id, :instants_id => @instants.id, :action => "search_invite", :parameters => code)
    
    if @instants.version == 1 then            
      invite_code = conn.exec("SELECT member_id FROM invite_code where code = '#{code}';")
      return false if invite_code.count == 0
      return {"status" => "unsed", "username" => false, "userid" => false, "email" => false} if invite_code.getvalue(0,0).nil?
      return conn.exec("SELECT id as userid, login as username ,active as status, notify_email as email FROM member where id = #{invite_code.getvalue(0,0)}").find_all.to_a.first
    end
  end
  
end
