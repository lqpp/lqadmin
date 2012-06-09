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
  
end