require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  test 'get random question id' do
    (0..50).each do
      element = Question.random_question
      assert_not_nil element['id']
      assert_not_nil element['question']
    end
  end
end
