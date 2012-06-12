class Emailer < ActionMailer::Base
   
   def username (username, email, sig, url)
     @subject = "Ihre Liquid Feedback Zugangsdaten"
     @recipients = email
     @from = 'admins@lqpp.de'
     @sent_on = Time.now
     @headers = {}
     
     @show = {}
     @show[:username] = username
     @show[:email]    = email
     @show[:sig]      = sig
     @show[:url]      = url
   end
   
   def admin_reset (email, pass)
     @subject = "Zugangsdaten LQFB Admin"
     @recipients = email
     @from = 'admins@lqpp.de'
     @sent_on = Time.now
     @headers = {}
     
     @show = {}
     @show[:url]    = "http://127.0.0.1:3000/login/update?register=#{pass}&email=#{email}"
   end
  
end