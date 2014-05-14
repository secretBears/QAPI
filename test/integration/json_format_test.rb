require 'test_helper'

class RoutesTest < ActionDispatch::IntegrationTest
  setup do
    token = User.last.api_key.token
    somequestion = Question.last
    get "/api/question/#{somequestion.id}", token: token
    @body = JSON.parse response_from_page.to_s
  end

  test 'test json output' do
    assert @body.key? 'id'
    assert @body.key? 'question'
    assert @body.key? 'answers'
    assert @body.key? 'place'

    assert @body.length, 4
    assert_equal @body['answers'].length, 4
  end

  test 'check types' do
    assert_equal @body['id'].class, Fixnum
    assert_equal @body['question'].class, String
    assert_equal @body['answers'].class, Array
    assert_equal @body['place'].class, String
  end

  test 'test json answers' do
    @body['answers'].each do |answer|
      assert answer.length, 2
      assert answer.key? 'answer'
      assert answer.key? 'isTrue'
    end
  end
end
