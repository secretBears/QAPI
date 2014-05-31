require 'test_helper'

class QAPIGeneratorTest < ActiveSupport::TestCase
  test 'should get quetion' do
    place = Place.find 1
    generator = QAPIGenerator.new place[:latitude], place[:longitude]
    question = generator.get

    assert_not_nil question

    assert question.key? :question
    assert question.key? :answers
  end

  test 'should get question from template' do
    question = QAPIGenerator.get_from_template 1, 1
    assert_not_nil question

    assert question.key? :question
    assert question.key? :answers
  end
end
