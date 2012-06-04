class Suche  
  
  
  def initialize(user, instants)
    
    @user     = user
    @instants = instants
    
    @permission = Permission.find_by_sql("select * from permissions where user_id = #{user.id} AND instants_id = #{instants.id}").first
    if @permission.nil? then 
      @permission = Permission.new()
    end
  end
  
  def get_user_permissions
    return @permission
  end
  
  def fulltext (text)
    return []
  end
  
  def invite (code)
    if code != "false" then
     return {:status => "used", :username => "Username", :userid => 1}
    else
      return nil
    end
  end
  
end
