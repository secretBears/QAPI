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
    assert_equal body['error'], '404'
    assert_not_nil body['error_desc'], 'not found'
    assert_response :success
  end

  test 'has question answers' do
    get :show, id: @question, format: :json

    body = JSON.parse response_from_page.to_s
    assert_equal body['answers'].class, Array
  end
end
