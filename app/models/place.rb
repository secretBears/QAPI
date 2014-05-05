require 'geokit'

class Place < ActiveRecord::Base
  has_many :questions, dependent: :delete_all
  include Geokit::Geocoders

  validates_uniqueness_of :latitude, scope: :longitude
  validates :city, :state, :country, :latitude, :longitude, presence: true

  def self.geolocate_from_latlong(lat, lang)
    locations = GoogleGeocoder.reverse_geocode "#{lat}, #{lang}"
    fail Exceptions::PlaceNotFound, "City Name with Coordinates lat=#{lat} long=#{lang} not found" if locations.city.nil?

    return Place.find_or_create_by!(
        city:      locations.city,
        country:   locations.country,
        state:     locations.state,
        latitude:  locations.lat,
        longitude: locations.lng
    ) if locations.success
  end
end
