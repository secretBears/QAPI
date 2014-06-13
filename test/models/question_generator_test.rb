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

  # TODO: test may be deprecated
  # test "should get question from static method" do
  #   query     = StaticHelperTest.generate_query
  #   templates = QuestionTemplate.random
  #   location  = Place.find(1)[:city]
  #
  #   templates.each do |template|
  #     question = QuestionGenerator.get query, template[:question], location
  #     assert_equal String, question.class
  #   end
  # end
end
