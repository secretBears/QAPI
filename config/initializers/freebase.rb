# this file initializes the freebase api

fail 'google api key not found' if ENV['GOOGLE_API_KEY'].nil?
FreebaseAPI.session = FreebaseAPI::Session.new(key: ENV['GOOGLE_API_KEY'], env: :sandbox)
