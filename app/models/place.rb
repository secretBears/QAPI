require 'geokit'

class Place < ActiveRecord::Base
  has_many :questions, dependent: :delete_all

  validates_uniqueness_of :latitude, scope: :longitude

  include Geokit::Geocoders

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
