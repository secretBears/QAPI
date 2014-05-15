require 'set'
class AnswerGenerator
  def initialize(arguments)
    @query        = arguments[:query]        || (fail ArgumentError, "query is required")
    @answer_limit = arguments[:answer_limit] || 3
  end

  def get(locations)
    locations = [locations] if locations.class == String
    answers = Set.new
    locations.each do |location|
      answers.add((@query.get location)['answer'])
    end
    answers
  end

  def self.get(locations, query, limit = 3)
    generator = AnswerGenerator.new query: query
    generator.get locations
  end

  def self.shuffle_answers(right_answer, wrong_answers)
    answers = []
    answers += (AnswerGenerator.as_set right_answer, true)
    answers += (AnswerGenerator.as_set wrong_answers, false)
    answers.shuffle!
  end

  private
  def self.as_set(answers, is_right)
    answers.map do |answer|
      {
          answer: answer,
          is_true: is_right
      }
    end
  end
end
