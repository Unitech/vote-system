# Be sure to restart your server when you modify this file.

if Rails.env.production? == true
  Votesystem::Application.config.session_store :cookie_store, :key => '_noctuagui_sess', :domain => '.vote-system.com'
else
  Votesystem::Application.config.session_store :cookie_store, :key => '_noctuagui_sess', :domain => '.lvh.me'
end

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Votesystem::Application.config.session_store :active_record_store
# requires Rails 3.0 RC or head
#Rails.application.config.session_store :cookie_store, :key => '_blogs_session', :domain => :all

# change top level domain size
#request.domain(2)
#request.subdomain(2)
#Rails.application.config.session_store :cookie_store, :key => '_blogs_session', :domain => "example.co.uk"
