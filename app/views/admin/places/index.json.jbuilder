json.array!(@places) do |place|
  json.extract! place, :id, :latitude, :longitude, :name
  json.url place_url(place, format: :json)
end
