require 'fakeweb'

def json_response(file_name)
  File.open(File.dirname(__FILE__) + '/../fixtures/fakeweb_' + file_name + '.json').read
end

# salzburg
FakeWeb.register_uri(
    :get,
    'https://maps.google.com/maps/api/geocode/json?sensor=false&latlng=47.8094888%2C13.0550007',
    body: (json_response 'sbg')
)

# vienna
FakeWeb.register_uri(
    :get,
    'https://maps.google.com/maps/api/geocode/json?sensor=false&latlng=48.208174%2C16.373819',
    body: (json_response 'vie')
)

# linz
FakeWeb.register_uri(
    :get,
    'https://maps.google.com/maps/api/geocode/json?sensor=false&latlng=48.30694%2C14.28583',
    body: (json_response 'lnz')
)

# new york
FakeWeb.register_uri(
    :get,
    'https://maps.google.com/maps/api/geocode/json?sensor=false&latlng=-33.867487%2C151.20699',
    body: (json_response 'ny')
)