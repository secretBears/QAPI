require 'test_helper'

class QAPIGeneratorTest < ActiveSupport::TestCase
  test 'should get quetion' do
    place = Place.find 1
    generator = QAPIGenerator.new place[:latitude], place[:longitude]
    questions = generator.get

    assert_not_nil questions

    questions.each do |question|
      assert question.key? :question
      assert question.key? :answers
    end
  end

  test 'should get question from template' do
    questions = QAPIGenerator.get_from_template 1, 1
    assert_not_nil questions

    questions.each do |question|
      assert question.key? :question
      assert question.key? :answers
    end
  end
end
