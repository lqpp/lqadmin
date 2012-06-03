class Suche  
  
  
  def x_initialize(user, instants)
    @permission = Permission.find_by_sql("select * from permissions where user_id = #{user.id} AND instants_id = #{instants.id}").first
    if @permission.nil? then 
      @permission = Permission.new()
    end
  end
  
  
  def fulltext (text)
    return []
  end
  
  def invite (code)
    return []
  end
  
end
