require 'geokit'

class Place < ActiveRecord::Base
  has_many :questions, dependent: :delete_all
  include Geokit::Geocoders

  validates :latitude, uniqueness: {scope: :longitude}
  validates :city, :state, :country, :latitude, :longitude, presence: true

  def to_name(key)
    self[key].to_s
  end

  def self.get_from_lat_lng(lat, lng)
    Place.find latitude: lat, longitude: lng
  end

  def self.get(lat, lng)
    lat = lat.to_f
    lng = lng.to_f

    place = Place.where(latitude: lat, longitude: lng).first
    return place unless place.blank?

    locations = GoogleGeocoder.reverse_geocode "#{lat}, #{lng}"
    fail Exceptions::PlaceNotFound, "City Name with Coordinates lat=#{lat} lng=#{lng} not found" if locations.city.nil?

    return Place.create!(
        city:      locations.city,
        country:   locations.country,
        state:     (locations.state || locations.district),
        latitude:  lat, # store the request coordinates
        longitude: lng
    ) if locations.success
  end

  # usage:
  # Place.get_without key: :country, place: 'Salzburg'
  # gets 3 places which are not in the country salzburg
  # available keys are [:city, :state, :country]
  def self.get_without(except,  limit = 3)
    fail ArgumentError, "#{except[:key]} is not a valid identifier for a place" unless location_keys.include? except[:key]
    places = limit(limit) # TODO: should be randomized
    places = places.where.not(except[:key] => except[:place])
    places
  end

  def self.as_array(records, key)
    fail ArgumentError, "#{key} is not a valid identifier for a place" unless location_keys.include? key
    records.map do |record|
      record[key]
    end
  end

  def self.location_keys
    [:city, :state, :country]
  end
end
