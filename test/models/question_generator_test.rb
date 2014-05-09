require 'test_helper'

class QuestionGeneratorTest < ActiveSupport::TestCase
  setup do
    # create query
    @query_hash = {
        "type" => "/people/person",
        "place_of_birth~=" => "Linz",
        "limit" => 1,
        "name" => nil,
        "profession" => [{
                             "name" => []
                         }]
    }

    @location_property = "place_of_birth~="
    @answer_property   = "profession"

    @query = Query.new(
        query_hash: @query_hash,
        location_property: @location_property,
        answer_property: @answer_property
    )

    @question_generator = QuestionGenerator.new(
        query:    @query,
        location: 'Salzburg',
        template: 'Welchen Beruf hatte ?name'
    )

  end

  test 'should get array from extract placeholder' do
    result = @question_generator.send :extract_placeholder

    assert_not_nil result
    assert_equal result.class, Array
  end

  test 'should replace all placeholder' do
    placeholders   = @question_generator.send :extract_placeholder
    question_cache = @question_generator.instance_variable_get(:@template)

    replace  = {}
    placeholders.each do |placeholder|
      replace[placeholder.gsub(/\?/, '')] = LoremIpsum.lorem_ipsum words: 1
    end

    new_question = @question_generator.send :replace_placeholder, placeholders, replace

    assert_not_equal new_question, question_cache
    assert_nil new_question.match(@question_generator.send :regex_placeholder)
    assert_not_nil question_cache.match(@question_generator.send :regex_placeholder)
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
    question = @question_generator.generate query
    assert_equal question.class, String
    assert_nil question.match(@question_generator.send :regex_placeholder)
  end
end
