require 'test_helper'

class QuestionGeneratorTest < ActiveSupport::TestCase
  setup do
    @query = {
        "type" => "/people/person",
        "place_of_birth~=" => "Linz",
        "limit" => 1,
        "name" => nil,
        "profession" => [{
           "name" => []
        }]
    }

    @answer_generator = AnswerGenerator.new(
        location: 'Salzburg',
        template: 'Welchen Beruf hatte ?name'
    )
  end
end
