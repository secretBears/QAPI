require 'test_helper'
require 'active_model/serializers/json'

class QuestionsControllerTest < ActionController::TestCase
  setup do
    @controller = QuestionsController.new
    @question = Question.first
  end

  test 'should get random question' do
    get :show_random, format: :json
    assert_response :success
  end

  test 'should return 404' do
    get :show_lat_long, latitude: 1_000_000, longitude: 1_000_000, format: :json
    assert_response :not_found
  end

  test 'should find no existing questions' do
    # values for city gramastetten
    lat  = 48.379944
    long = 14.192699
    get :show_lat_long, latitude: lat, longitude: long, format: :json
  end
end
