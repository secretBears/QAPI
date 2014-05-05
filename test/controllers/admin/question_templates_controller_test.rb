require 'test_helper'

class Admin::QuestionTemplatesControllerTest < ActionController::TestCase
  setup do
    @question_template = QuestionTemplate.find(1)
    @user = User.find(1)
    sign_in @user
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:question_templates)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create question_template' do
    assert_difference('QuestionTemplate.count') do
      post :create, question_template: {
        question: LoremIpsum.lorem_ipsum(words: 15),
        question_id: 2
      }
    end

    assert_redirected_to admin_question_template_path(assigns(:question_template))
  end

  test 'should show question_template' do
    get :show, id: @question_template
    assert_response :success
  end

  test 'should get edit' do
    get :edit, id: @question_template
    assert_response :success
  end

  test 'should update question_template' do
    new_question_text = LoremIpsum.lorem_ipsum(words: 15)
    patch :update, id: @question_template, question_template: {
      question: new_question_text
    }

    assert_redirected_to admin_question_template_path(assigns(:question_template))
  end

  test 'should destroy question_template' do
    assert_difference('QuestionTemplate.count', -1) do
      delete :destroy, id: @question_template
    end

    assert_redirected_to admin_question_templates_path
  end

  test 'test extract params' do

  end
end
