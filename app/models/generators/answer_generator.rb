# answer_generator.rb
# is used to generate answers to a given query

require 'set'
class AnswerGenerator
  def initialize(arguments)
    @query        = arguments[:query]        || (fail ArgumentError, "query is required")
    @answer_limit = arguments[:answer_limit] || 3
  end

  def get(locations)
    locations = Array(locations) if locations.class == String
    locations.map do |location|
      answers  = @query.results location
      answers.map do |answer|
        answer[:answer]
      end
    end
  end

  def self.get(locations, query, _limit = 3)
    generator = AnswerGenerator.new query: query
    generator.get locations
  end

  def self.shuffle_answers(right_answer, wrong_answers)
    answers = []
    answers += (AnswerGenerator.as_set right_answer, true)
    answers += (AnswerGenerator.as_set wrong_answers, false)
    answers.shuffle!
  end

  def self.as_set(answers, is_right)
    answers.map do |answer|
      {
        answer: answer,
        is_true: is_right
      }
    end
  end
end
