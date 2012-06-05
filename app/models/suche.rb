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
    if text != "false" then
      out = []
      out << {:username => "Username 1", :userid => 1, :email => "test_1@mail.de"}
      out << {:username => "Username 2", :userid => 2, :email => "test_2@mail.de"}
      out << {:username => "Username 3", :userid => 3, :email => "test_3@mail.de"}
      
     return out
    else
      return nil
    end
  end
  
  def invite (code)
    if code != "false" then
     return {:status => "used", :username => "Username", :userid => 1, :email => "test@mail.de"}
    else
      return nil
    end
  end
  
end
