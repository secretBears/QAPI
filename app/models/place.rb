require 'geokit'

class Place < ActiveRecord::Base
  has_many :questions, dependent: :delete_all

  validates :latitude, uniqueness: {scope: :longitude}
  validates :city, :state, :country, :latitude, :longitude, presence: true

  include Geokit::Geocoders

  scope :find_by_lat_lng, -> (lat, lng) {find_by(latitude: lat, longitude: lng) }

  # Get a place to given coordinates
  # if the coords are stored in the database the function returns this object
  # if nothing is stored in the database this function will reverse geocode this coordinates
  # and store the object in the database
  #
  # usage:
  #
  # Place.get 12.32, -32.12
  #
  def self.get(original_lat, original_lng)
    lat = original_lat.to_f.round 4
    lng = original_lng.to_f.round 4

    place = Place.find_by_lat_lng lat, lng
    return place unless place.blank?

    locations = GoogleGeocoder.reverse_geocode "#{original_lat}, #{original_lng}"
    fail Exceptions::PlaceNotFound, "City Name with Coordinates lat=#{original_lat} lng=#{original_lng} not found" if locations.city.nil?

    return Place.create!(
        city:      locations.city,
        country:   locations.country,
        state:     (locations.state || locations.district),
        latitude:  lat,
        longitude: lng
    ) if locations.success
  end

  # Gets a Place without the given place
  #
  # @example
  #   Place.get_without key: :country, place: 'Salzburg'
  #
  # gets 3 places which are not in the country salzburg
  #
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

  # returns a given key to a string
  def to_name(key)
    self[key].to_s
  end

end
