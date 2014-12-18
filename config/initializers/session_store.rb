# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_prototype1_session',
  :secret      => 'ecb8d73d1fbc9dac9f0503015968377a80eff00c4d1b18eccc9cabaa838a6408b5ee1e9e7565e820600ed59943538bf232e7d521c81f56cdb129af77928179d4'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
