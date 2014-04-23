require 'test_helper'

class RoutesTest < ActionDispatch::IntegrationTest
  test "test output format" do
    assert_generates "/api/question/one", controller: "questions", action: "show", id: "one", format: :json
    assert_generates "/api/question/-1",  controller: "questions", action: "show", id: "-1", format: :json
    assert_generates "/api/question",     controller: "questions", action: "show_random", format: :json
  end

  test "question has answers" do

  end
end
