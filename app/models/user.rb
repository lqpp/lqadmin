class User < ActiveRecord::Base
  
    has_many :permissions
  
    require 'digest/sha1'
    def pass= (pass)
      return false if self.pass == pass
      write_attribute("pass", Digest::SHA1.hexdigest(pass))
      Log.create(:user_id => self.id, :instants_id => 0, :action => "user", :parameters => "set passwort")
    end
    
    def update_pass(old, pass)
      return false if self.pass != Digest::SHA1.hexdigest(old)
      self.pass= pass;
      self.save
      return true
    end
    
    def self.authenticate(email, pass)
      return nil if email.nil? or pass.nil?
      back = find_by_email_and_pass(email,Digest::SHA1.hexdigest(pass))
      if back.nil? then
        Log.create(:user_id => 0, :instants_id => 0, :action => "login_false", :parameters => email)
      else
        Log.create(:user_id => back.id, :instants_id => 0, :action => "user", :parameters => "login")
      end
      return back
    end
end