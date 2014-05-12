require 'test_helper'

class QuestionTemplateTest < ActiveSupport::TestCase
  test "get random template" do
    template = QuestionTemplate.random
    assert_not_nil template
  end

  test "should get multiple records" do
    templates = QuestionTemplate.random 2
    assert_not_nil templates
    assert_equal templates.length, 2
  end
end
