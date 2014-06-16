require 'fakeweb'

geocode_server = "http://quiz.mediacube.at/maps"

# FakeWeb.allow_net_connect = false

def json_response(file_name)
  File.open(File.dirname(__FILE__) + '/../fixtures/fakeweb_' + file_name + '.json').read
end

# salzburg
FakeWeb.register_uri(
  :get,
  "#{geocode_server}/maps/api/geocode/json?sensor=false&latlng=47.8095%2C13.055",
  body: (json_response 'sbg')
)

# vienna
FakeWeb.register_uri(
  :get,
  "#{geocode_server}/maps/api/geocode/json?sensor=false&latlng=48.2082%2C16.3738",
  body: (json_response 'vie')
)

# linz
FakeWeb.register_uri(
  :get,
  "#{geocode_server}/maps/api/geocode/json?sensor=false&latlng=48.3069%2C14.2858",
  body: (json_response 'lnz')
)

# new york
FakeWeb.register_uri(
  :get,
  "#{geocode_server}/maps/api/geocode/json?sensor=false&latlng=-33.8675%2C151.207",
  body: (json_response 'ny')
)

# freebase politic
FakeWeb.register_uri(
  :get,
  /date_of_birth%22%3Anull%2C%22limit%22%3A15%2C%22name%22%3Anull%2C%22profession%22%3A%5B%7B%22name%22%3A%22Politician%22%7D%5D%7D%5D/,
  body: (json_response 'mql_politic')
)

# freebase music
FakeWeb.register_uri(
    :get,
    /limit%22%3A50%2C%22name%22%3Anull%2C%22genre%22%3A%5B%7B%22name%22%3Anull%2C%22limit%22%3A1%7D%5D%7D%5D/,
    body: (json_response 'mql_music')
)

# freebase music
FakeWeb.register_uri(
    :get,
    /profession%22%3A%5B%7B%22name%22%3A%5B%5D%2C%22limit%22%3A1%7D%5D%7D%5D/,
    body: (json_response 'mql_person')
)

FakeWeb.register_uri(
    :get,
    /name%22%3A%22dskfjlsakdsjflajdlkf%C3%B6jsflsfjl314%22%2C%22album%22%3A%5B%5D%7D/,
    body: (json_response 'nil')
)

FakeWeb.register_uri(
    :get,
    /profession%22%3A%5B%7B%22name%22%3A%5B%5D%7D%5D%7D%5D/,
    body: (json_response 'mql_person')
)
