require 'test_helper'

class QuestionGeneratorTest < ActiveSupport::TestCase
  setup do
    @query =
    @question_generator = AnswerGenerator.new(
        location: 'Salzburg',
        template: 'Welchen Beruf hatte ?name'
    )
  end
  #
  # test "should get answers" do
  #   @question_generator.generate
  # end
end
