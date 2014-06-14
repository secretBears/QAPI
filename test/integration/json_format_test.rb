require 'test_helper'

class RoutesTest < ActionDispatch::IntegrationTest
  setup do
    token = User.last.api_key.token
    some_place = Place.first
    get "/api/#{some_place.latitude}/#{some_place.longitude}", token: token
    @body = JSON.parse response_from_page.to_s
  end

  test 'result has to be an array' do
    assert_equal Array, @body.class, "Result was not an array"
  end

  test 'elements of result-array should be a hash' do
    @body.each do |question|
      assert_equal Hash, question.class, "Element was not a hash"
    end
  end

  test 'Individual questions should contain question string and answers array' do
    @body.each do |question|
      assert_equal question['id'].class, Fixnum, '"id" not present in question-hash or not Fixnum'
      assert_equal question['question'].class, String, '"question" not present in question-hash or not String'
      assert_equal question['answers'].class, Array, '"answers" not present in question-hash or not Array'
    end
  end

  # TODO: is currently not working in tests because of mocking
  #
  # test 'answers array should be exactly 4 elements long' do
  #   @body.each do |question|
  #     assert_equal 4, question['answers'].length, 'Answers array is not of length 4'
  #   end
  # end

  test 'individual answers should contain answer and isTrue flag' do
    @body.each do |question|
      question["answers"].each do |answer|
        assert answer.key? "answer"
        assert answer.key? "isTrue"
      end
    end
  end
end
