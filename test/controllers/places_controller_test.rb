require 'test_helper'

class PlacesControllerTest < ActionController::TestCase
  setup do
    @place = Place.find(1)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:places)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create place' do
    assert_difference('Place.count') do
      post :create, latitude: 11.11, longitude: 12.12, name: 'Gotham City'
    end

    assert_redirected_to place_path(assigns(:place))
  end

  test 'should show place' do
    get :show, id: @place
    assert_response :success
  end

  test 'should get edit' do
    get :edit, id: @place
    assert_response :success
  end

  test 'should update place' do
    patch :update, id: @place, place: {latitude: @place.latitude, longitude: @place.longitude, name: @place.name}
    assert_redirected_to place_path(assigns(:place))
  end

  test 'should destroy place' do
    assert_difference('Place.count', -1) do
      delete :destroy, id: @place
    end

    assert_redirected_to places_path
  end

  test 'test geocode' do
    lat  = 48
    long = 14
    assert_difference('Place.count', +1) do
      post :geocode, latitude: lat, longitude: long
    end

    assert_difference('Place.count', 0) do
      post :geocode, latitude: lat, longitude: long
    end
  end
end
