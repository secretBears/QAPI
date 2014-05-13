require 'test_helper'

class PlaceTest < ActiveSupport::TestCase
  setup do
    @location = Place.find 1
  end

  test "should get locations except city" do
    places = Place.get_locations_without key: :city, place: @location[:city]
    places.each do |place|
      assert_not_equal @location[:city], place[:city]
    end
  end

  test "should get locations except country" do
    places = Place.get_locations_without key: :country, place: @location[:country]
    places.each do |place|
      assert_not_equal @location[:country], place[:country]
    end
  end

  test "should get locations except state" do
    places = Place.get_locations_without key: :state, place: @location[:state]
    places.each do |place|
      assert_not_equal @location[:state], place[:state]
    end
  end

  test "should get string" do
    city = @location.to_name :city
    state = @location.to_name :state
    country = @location.to_name :country

    assert_not_nil city
    assert_not_nil state
    assert_not_nil country

    assert_equal String, city.class
    assert_equal String, state.class
    assert_equal String, country.class
  end

  test "should get set" do
    location  = Place.find(1)[:city]
    locations = Place.get_locations_without key: :city, place: location
    as_array = Place.as_array locations, :city

    assert_equal Array, as_array.class
    as_array.each do |item|
      assert_equal String, item.class
    end
  end
end
