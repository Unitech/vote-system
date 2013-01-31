Rails.application.config.middleware.use OmniAuth::Builder do
#  provider :twitter, 'CONSUMER_KEY', 'CONSUMER_SECRET'
  # if "production" == RAILS_ENV
  #   provider :facebook, "203579716359998", "6e940088da020b938daf12fa5c010d88"
  # else
  #provider :facebook, "141985072549308", "ff33b87c913a49facec304cb569bef62"
#  provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'
end
