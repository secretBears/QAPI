require 'test_helper'

class QuestionTemplateTest < ActiveSupport::TestCase
  setup do
    @question = QuestionTemplate.find(1)
  end

  test "extract_params_func" do
    result = @question.send :extract_placeholder

    assert_not_nil result
    assert_equal result.class, Array
  end

  test "replace placeholder" do
    result = @question.send :extract_placeholder
    question_cache = @question.question
    r  = {}
    result.each do |placeholder|
      r[placeholder] = LoremIpsum.lorem_ipsum words: 1
    end

    new_question = @question.send :replace_placeholder, r

    assert_not_equal new_question, question_cache
    assert_nil new_question.match(@question.send :regex_placeholder)
    assert_not_nil question_cache.match(@question.send :regex_placeholder)
  end
end
