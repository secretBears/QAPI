require 'test_helper'
require 'active_model/serializers/json'

class QuestionsControllerTest < ActionController::TestCase
  setup do
    @controller = QuestionsController.new
    @question = Question.first
    @token = User.first.api_key.token
    @place = Place.first
    @admin = User.admins.first
  end

  test 'should not get result without token as guest' do
    get :index_lat_lng, lat: @place.latitude, lng: @place.longitude, format: :json
    assert_response 403, 'could get questions without token as non-admin'
  end

  test 'should get result as admin without token' do
    sign_in @admin
    get :index_lat_lng, lat: @place.latitude, lng: @place.longitude, format: :json
    assert_response :success, 'could not get questions without token as admin'
  end

  test 'should get result as non-admin with token' do
    get :index_lat_lng, lat: @place.latitude, lng: @place.longitude, token: @token, format: :json
    assert_response :success
  end

  test 'should get response for test template' do
    mql  = '%5B%7B%22type%22%3A%22%2Fpeople%2Fperson%22%2C%22place_of_birth~%3D%22%3A%22Linz%22%2C%22limit%22%3A1%2C%22name%22%3Anull%2C%22'
    mql += 'profession%22%3A%5B%7B%22name%22%3A%5B%5D%7D%5D%7D%5D'

    template  = 'Lorem%20ipsum%20dolor%20sit%20amet%2C%20consectetuer%'
    template += '20adipiscing%20elit.%20Nam%20cursus.%20Morbi%20%3Fname%20mi.%20Nullam%20enim'

    get :test_query,
        place_id: 1,
        mql: mql,
        location_property: 'place_of_birth~%3D',
        answer_property: '%24.profession%5B*%5D.name',
        template_property: template,
        token: '4e31ed23c464a5abe3d7af57ee23ec72'
   assert_response :success
  end

end
