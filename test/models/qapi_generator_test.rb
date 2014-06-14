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
    questions = QAPIGenerator.get_from_ids 1, 1
    assert_not_nil questions
  end

end
