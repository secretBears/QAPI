require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  test 'should get question to lat long' do
    place = Place.find 1
    question = Question.find_by_lat_long latitude: place.latitude, longitude: place.longitude
    assert_not_nil question
  end
end
