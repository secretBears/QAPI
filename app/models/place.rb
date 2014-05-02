require 'geokit'

class Place < ActiveRecord::Base
  has_many :questions, dependent: :delete_all

  validates_uniqueness_of :latitude, scope: :longitude
  validates :name, :latitude, :longitude, presence: true

  include Geokit::Geocoders

  def self.geolocate_from_latlong(lat, lang)
    locations = GoogleGeocoder.reverse_geocode "#{lat}, #{lang}"
    return Place.find_or_create_by!(
        name:      locations.city,
        latitude:  locations.lat,
        longitude: locations.lng
    ) if locations.success

    rescue
      nil
  end
end
