# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_lqadmin_session',
  :secret      => 'cd4faf78948b6e9c9eb5769a602ce6003da14cf185a2da29ccd5b29590440924ede3f57b4f112dd90e93e28df7df9625a4f7931d92dbe5084c4711ff0fad8348'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
