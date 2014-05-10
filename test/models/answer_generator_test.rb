require 'test_helper'

class AnswerGeneratorTest < ActiveSupport::TestCase
  setup do
    @answer_generator = AnswerGenerator.new(
        query: StaticHelperTest.generate_query
    )
  end

  test "should get answers from string" do
    answer = @answer_generator.get 'Linz'

    assert_not_nil answer
    assert_equal Set, answer.class
  end

  test "should get answers from array" do
    answer = @answer_generator.get %w'Linz Salzburg'

    assert_not_nil answer
    assert_equal Set, answer.class
  end

  test "should get answers in combination with place_without methode" do
    places = Place.get_locations_without key: :city, place: 'Salzburg'
    answers = []
    places.each do |place|
      name = place.to_name :city
      answers.push (@answer_generator.get name)
    end
  end
end
