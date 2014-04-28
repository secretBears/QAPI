require 'test_helper'

class QuestionTemplateTest < ActiveSupport::TestCase
  setup do
    @question = QuestionTemplate.find(1)
  end

  test "extract_params_func" do
    result = @question.extract_placeholder

    assert_not_nil result
    assert_equal result.class, Array
  end

end
