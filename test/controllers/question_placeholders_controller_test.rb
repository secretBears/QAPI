require 'test_helper'

class QuestionPlaceholdersControllerTest < ActionController::TestCase
  setup do
    @question_placeholder = QuestionPlaceholder.find 1
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:question_placeholders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create question_placeholder" do
    assert_difference('QuestionPlaceholder.count') do
      post :create, question_placeholder: {
        key: @question_placeholder.key,
        question_template_id: @question_placeholder.question_template_id,
        value: @question_placeholder.value
      }
    end

    assert_redirected_to question_placeholder_path(assigns(:question_placeholder))
  end

  test "should show question_placeholder" do
    get :show, id: @question_placeholder
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @question_placeholder.id
    assert_response :success
  end

  test "should update question_placeholder" do
    patch :update, id: @question_placeholder, question_placeholder: {
      key: @question_placeholder.key,
      question_template_id: @question_placeholder.question_template_id,
      value: @question_placeholder.value
    }
    assert_redirected_to question_placeholder_path(assigns(:question_placeholder))
  end

  test "should destroy question_placeholder" do
    assert_difference('QuestionPlaceholder.count', -1) do
      delete :destroy, id: @question_placeholder
    end

    assert_redirected_to question_placeholders_path
  end
end
