# this file initializes the freebase api

FreebaseAPI.session = FreebaseAPI::Session.new(key: ENV['GOOGLE_API_KEY'], env: :stable)
