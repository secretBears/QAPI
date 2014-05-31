require 'test_helper'

class APITest < ActionDispatch::IntegrationTest
  setup do
    @token = User.last.api_key.token
  end

  test 'should get question' do
    get "/api/47.8094888/13.0550007/?token=#{@token}"
    response = JSON.parse response_from_page.to_s

    response.each do |question|
      assert question.key? 'question'
      assert question.key? 'answers'
    end
  end

  test 'should have answers' do
    get "/api/47.8094888/13.0550007/?token=#{@token}"
    response = JSON.parse response_from_page.to_s

    response.each do |question|
      question['answers'].each do |answer|
        assert answer.key? 'answer'
        assert answer.key? 'is_true'
      end
    end
  end
end
