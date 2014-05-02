require 'test_helper'
require 'active_model/serializers/json'

class QuestionsControllerTest < ActionController::TestCase
  setup do
    @question = Question.first
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:questions)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create question' do
    assert_difference('Question.count') do
      post :create, question: {question: 'unique test question'}
    end

    assert_redirected_to question_path(assigns(:question))
  end

  test 'should show question' do
    get :show, id: @question
    assert_response :success
  end

  test 'should get edit' do
    get :edit, id: @question
    assert_response :success
  end

  test 'should update question' do
    patch :update, id: @question, question: {question: 'unique update question'}
    assert_redirected_to question_path(assigns(:question))
  end

  test 'should destroy question' do
    assert_difference('Question.count', -1) do
      assert_difference('Answer.count', -4) do
        delete :destroy, id: @question
      end
    end

    assert_redirected_to questions_path
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
end
