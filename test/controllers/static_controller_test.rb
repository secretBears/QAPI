require 'test_helper'

class StaticControllerTest < ActionController::TestCase
  test 'should show index page' do
    get :index
    assert_response :success
  end
end
