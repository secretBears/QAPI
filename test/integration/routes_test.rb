require 'test_helper'

class RoutesTest < ActionDispatch::IntegrationTest
  test "test output format" do
    assert_generates "/api/question/one", controller: "questions", action: "show", id: "one", format: :json
    assert_generates "/api/question",     controller: "questions", action: "show_random", format: :json
  end
end
