class User < ActiveRecord::Base
  
    has_many :permissions
  
    require 'digest/md5'
    def pass= (pass)
      write_attribute("pass", Digest::MD5.hexdigest(pass))
      #self.pass = Digest::MD5.hexdigest(pass)
    end
    
    def self.authenticate(email, pass)
      return nil if email.nil? or pass.nil?
      find_by_email_and_pass(email,Digest::MD5.hexdigest(pass))
    end
end