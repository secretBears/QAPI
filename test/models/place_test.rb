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
end
