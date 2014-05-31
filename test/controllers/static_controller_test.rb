require 'test_helper'

class StaticControllerTest < ActionController::TestCase
  def setup
    @user = User.first
  end

  test 'should show index page' do
    sign_in @user
    get :index
    assert_response :success
  end
end
