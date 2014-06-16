require 'test_helper'

class AnswerGeneratorTest < ActiveSupport::TestCase
  setup do
    @answer_generator = AnswerGenerator.new(
        query: Query.first
    )
  end

  test "should find unique answers from database" do
    query = Query.first
    generator = AnswerGenerator.new query: query
    answers = generator.find_answers_from_db

    refute answers.blank?
    assert_equal answers.uniq.length, answers.length
  end

  test "should find unique answers from different location" do
    query = Query.first
    generator = AnswerGenerator.new query: query
    answers = generator.find_answers_from_query

    refute answers.blank?
    assert_equal answers.uniq.length, answers.length
  end


  test "should get answers from string" do
    answer = @answer_generator.get 'Linz'

    assert_not_nil answer
    assert_equal Array, answer.class
  end

  test "should get answers from array" do
    answer = @answer_generator.get %w(Linz Salzburg)

    assert_not_nil answer
    assert_equal Array, answer.class
  end

  test "should get answers in combination with place_without methode" do
    places = Place.get_without key: :city, place: 'Salzburg'
    answers = []
    places.each do |place|
      name = place.to_name :city
      answers.push(@answer_generator.get name)
    end
  end

  test "should get answer from static method" do
    query     = Query.first
    location  = Place.find(1)[:city]
    locations = Place.get_without key: :city, place: location
    locations = Place.as_array locations, :city

    answers = AnswerGenerator.get locations, query
    assert_equal Array, answers.class
  end

  test "should shuffle answers" do
    right_answer = Set.new ['i am right']
    wrong_answers = Set.new %w(wrong1 wrong2 wrong3)

    shuffle = AnswerGenerator.shuffle_answers right_answer, wrong_answers
    assert_equal Array, shuffle.class
    shuffle.each do |answer|
      assert answer.key? :answer
      assert answer.key? :is_true
    end
  end
end
