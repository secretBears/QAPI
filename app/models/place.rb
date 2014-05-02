require 'geokit'

class Place < ActiveRecord::Base
  has_many :questions, dependent: :delete_all

  include Geokit::Geocoders
  def self.geolocate_from_name(*args)
    puts Geokit::Geocoders::GoogleGeocoder.geocode '140 Market St, San Francisco, CA'
    # raise "not implemented"
  end

  def self.geolocate_from_latlong(lat, lang)
    locations = GoogleGeocoder.reverse_geocode "#{lat}, #{lang}"
    return Place.find_or_create_by!(
        name:      locations.city,
        latitude:  locations.lat,
        longitude: locations.lng
    ) if locations.success
    nil
  end
end
