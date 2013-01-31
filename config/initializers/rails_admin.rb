RailsAdmin.config do |config|
  
  config.authenticate_with {  } # leave it to authorize
  config.authorize_with do
    redirect_to main_app.new_user_session_path unless current_user.try(:admin?)
  end
  
end
