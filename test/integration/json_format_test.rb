require 'test_helper'

class RoutesTest < ActionDispatch::IntegrationTest
  setup do
    get "/api/question/1"
    @body = JSON.parse response_from_page.to_s
  end

  test "test json output" do
    assert @body.key? 'id'
    assert @body.key? 'question'
    assert @body.key? 'answers'
    assert_equal @body['answers'].class, Array
    assert_equal @body['answers'].length, 4
  end

  test "test json answers" do
    @body['answers'].each do |answer|
      assert answer.length, 2
      assert answer.key? 'answer'
      assert answer.key? 'is_true'
    end
  end
end
