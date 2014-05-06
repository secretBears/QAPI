require 'test_helper'

class QuestionGeneratorTest < ActiveSupport::TestCase
  setup do
    @question_generator = AnswerGenerator.new(
        location: 'Salzburg',
        template: 'Welchen Beruf hatte ?name'
    )
  end
end
