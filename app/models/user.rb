class User < ActiveRecord::Base
  
    has_many :permissions
  
    require 'digest/sha1'
    def pass= (pass)
      write_attribute("pass", Digest::SHA1.hexdigest(pass))
    end
    
    def self.authenticate(email, pass)
      return nil if email.nil? or pass.nil?
      find_by_email_and_pass(email,Digest::SHA1.hexdigest(pass))
    end
end