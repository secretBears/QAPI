# this file initializes the freebase api
puts "---------------"
puts ENV['GOOGLE_API_KEY'].nil?
puts ENV['GOOGLE_API_KEY']
puts "---------------"


fail 'google api key not found' if ENV['GOOGLE_API_KEY'].nil?
FreebaseAPI.session = FreebaseAPI::Session.new(key: ENV['GOOGLE_API_KEY'], env: :stable)
