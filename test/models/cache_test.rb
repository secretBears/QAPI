require 'test_helper'

class CacheTest < ActiveSupport::TestCase
  test 'should delete all questions and answers' do
    Cache.clear_all_questions

    assert_equal 0, Question.count
    assert_equal 0, Answer.count
  end

  test 'should delete all questions' do
    Cache.clear_all_places
    assert_equal 0, Place.count
  end

  test 'should delete all questions for template' do
    template = QuestionTemplate.last
    Cache.clear_questions_from_template template.id

    questions = Question.where question_template_id: template.id
    assert_empty questions
  end
end