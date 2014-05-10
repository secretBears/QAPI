require 'test_helper'

class QuestionGeneratorTest < ActiveSupport::TestCase
  setup do
    # create query
    @question_generator = QuestionGenerator.new(
        query:    StaticHelperTest.generate_query,
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

  test "should generate a question" do
    question = @question_generator.get 'Linz'
    assert_equal question.class, String
    assert_nil question.match(@question_generator.send :regex_placeholder)
  end
end
