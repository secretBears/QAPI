require 'test_helper'

class QuestionGeneratorTest < ActiveSupport::TestCase
  setup do
    @question_generator = QuestionGenerator.new location: 'Salzburg'
  end

  test "should get the police" do
    query = {
        type: '/music/artist',
        name: 'The Police',
        album: []
    }
    result = @question_generator.send :fire_query, query

    assert_not_nil result
    assert_nil result['error']
  end

  test "should raise query not found" do
    assert_raise Exceptions::QueryNotFound do
      query = {
          type: '/music/artist',
          name: 'dskfjlsakdsjflajdlkföjsflsfjl314', # i hope that this is not a valid band name =)
          album: []
      }
      @question_generator.send :fire_query, query
    end
  end

  test "should raise argument error" do
    assert_raise ArgumentError do
      QuestionGenerator.new test: "hallo"
    end
  end
end
