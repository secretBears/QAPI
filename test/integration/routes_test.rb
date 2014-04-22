require 'test_helper'

class RoutesTest < ActionDispatch::IntegrationTest
  test "test" do
    assert_generates "/api/question/one", controller: "questions", action: "show", id: "one", format: :json
  end
end
