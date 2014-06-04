require 'test_helper'

class QAPIGeneratorTest < ActiveSupport::TestCase
  test 'should get quetion' do
    place = Place.first
    generator = QAPIGenerator.new place[:latitude], place[:longitude]
    questions = generator.get

    assert_not_nil questions

    questions.each do |question|
      assert question.question
    end
  end

  test 'should get question from template' do
    questions = QAPIGenerator.get_from_template 1, 1
    assert_not_nil questions
  end

  test 'should get question from place and template' do
    template = QuestionTemplate.first
    place    = Place.first
    question = QAPIGenerator.get_from_template_and_place template, place

    assert_not_nil question
  end
end
