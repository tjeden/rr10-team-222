Rails.application.config.middleware.use OmniAuth::Builder do
#provider :twitter, 'CONSUMER_KEY', 'CONSUMER_SECRET'
#  provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'
  if Rails.env == "production"
    provider :facebook, '168478876501692', '9909b0c54507ab2be976d80ac540e623'
  else
    provider :facebook, '104273762973020', 'f63a66064030688b79bc57e5fe153e97'
  end
end
