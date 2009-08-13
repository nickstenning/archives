# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_archives_session',
  :secret      => 'f4eb3af8749bea9a4c181108ed391ed01caa18a9a78495284221920cb85a85fdab96b89ba458183a2e8836b8e7cd408fdf2c09e8895a24221006bf5b8e2716e8'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
