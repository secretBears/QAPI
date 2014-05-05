require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  test 'get random question id' do
    (0..50).each do
      element = Question.random_question
      assert_not_nil element['id']
      assert_not_nil element['question']
    end
  end

  test 'should get question to lat long' do
    place = Place.find 1
    question = Question.find_by_lat_long latitude: place.latitude, longitude: place.longitude
    assert_not_nil question
  end

end
