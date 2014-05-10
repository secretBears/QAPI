require 'test_helper'

class AnswerGeneratorTest < ActiveSupport::TestCase
  setup do
    @answer_generator = AnswerGenerator.new(
        query: StaticHelperTest.generate_query
    )
  end

  test "should get answers" do
    answer = @answer_generator.get ['Linz']

    assert_not_nil answer
    assert_equal Array, answer.class
  end
end
