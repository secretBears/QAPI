require 'test_helper'
require 'active_model/serializers/json'

class QuestionsControllerTest < ActionController::TestCase
  setup do
    @question = Question.first
  end

  test 'should get random question' do
    get :show_random, format: :json
    assert_response :success
  end

  test 'should get error if question does not exist' do
    get :show, id: -1, format: :json

    body = JSON.parse response_from_page.to_s

    assert_equal body.class, Hash
    assert_equal body['error'], 404
    assert_not_nil body['message']
    assert_response :not_found
  end

  test 'has question answers' do
    get :show, id: @question, format: :json
    body = JSON.parse response_from_page.to_s
    assert_equal body['answers'].class, Array
  end

  test 'show lat long' do
    place = Place.find 1
    get :show_lat_long, latitude: place.latitude, longitude: place.longitude, format: :json
    assert_response :success
  end

  test 'should return 404' do
    get :show_lat_long, latitude: 1000000, longitude: 1000000, format: :json
    assert_response :not_found
  end

  test 'should find no existing questions' do
    # values for city gramastetten
    lat  = 48.379944
    long = 14.192699
    get :show_lat_long, latitude: lat, longitude: long, format: :json
  end
end
