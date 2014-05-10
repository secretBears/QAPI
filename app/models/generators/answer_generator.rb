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
end
