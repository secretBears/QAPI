require 'test_helper'

class QuestionGeneratorTest < ActiveSupport::TestCase
  setup do
    # create query
    @question_generator = QuestionGenerator.new(
        place:    'Salzburg',
        template: QuestionTemplate.first
    )
  end

  test "should raise argument error" do
    assert_raise ArgumentError do
      QuestionGenerator.new test: "hallo"
    end
  end
end
