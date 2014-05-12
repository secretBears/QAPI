require 'test_helper'

class QAPIGeneratorTest < ActiveSupport::TestCase
  test 'should get quetion' do
    place = Place.find 1
    generator = QAPIGenerator.new place[:latitude], place[:longitude]
    question = generator.get

    assert_not_nil question
  end
end
