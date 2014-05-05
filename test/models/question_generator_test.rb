require 'test_helper'

class QuestionGeneratorTest < ActiveSupport::TestCase
  setup do
    @question_generator = QuestionGenerator.new(
        location: 'Salzburg',
        template: 'Welchen Beruf hatte ?name'
    )
  end

  test "should raise argument error" do
    assert_raise ArgumentError do
      QuestionGenerator.new test: "hallo"
    end
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

  test "should get people from linz" do
    query = {
      "type" => "/people/person",
      "place_of_birth~=" => "Linz",
      "limit" => 1,
      "name" => nil,
      "profession" => [{
        "name" => []
      }]
    }
    result =  @question_generator.send :fire_query, query
    assert_not_nil result
    assert_nil result['error']
  end

  test "should get people from vienna" do
    query = {
        "type" => "/people/person",
        "place_of_birth~=" => "vienna",
        "limit" => 1,
        "name" => nil,
        "profession" => [{
                             "name" => []
                         }]
    }
    result =  @question_generator.send :fire_query, query
    assert_not_nil result
    assert_nil result['error']
  end

  test "should generate a question" do
    query = {
        "type" => "/people/person",
        "place_of_birth~=" => "vienna",
        "limit" => 1,
        "name" => nil,
        "profession" => [{
                             "name" => []
                         }]
    }
    question = @question_generator.generate_question query
    assert_equal question.class, String
    assert_nil question.match(@question_generator.send :regex_placeholder)
  end
end
