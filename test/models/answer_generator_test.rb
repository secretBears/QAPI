require 'test_helper'

class QuestionGeneratorTest < ActiveSupport::TestCase
  setup do
    @location = Place.find(1)
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
        placeholder_field: "place_of_birth~=",
        answer_field: "profession",
        location: @location[:city],
        template: 'Welchen Beruf hatte ?name'
    )
  end
  #
  # test "should get answers" do
  #   answers = @answer_generator.generate @query
  #   assert_equal Set, answers.class
  # end
end
