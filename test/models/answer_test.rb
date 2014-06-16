require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  setup do
    answers = Answer.all.limit 3
    @answer_ids = answers.map do |answer|
      answer[:id]
    end
  end

  test 'should get three answers' do
    answers = Answer.find @answer_ids
    assert_equal 3, answers.count
  end
end
