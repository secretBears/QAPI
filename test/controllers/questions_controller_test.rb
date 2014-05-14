require 'test_helper'
require 'active_model/serializers/json'

class QuestionsControllerTest < ActionController::TestCase
  setup do
    @controller = QuestionsController.new
    @question = Question.first
    @token = User.first.api_key.token
  end

  test 'should not get result without token' do
    get :show, id: @question
    assert_response 401
  end

  test 'should get result with token' do
    get :show, id: @question, token: @token
    assert_response :success
  end

end
