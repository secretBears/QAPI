require 'set'
class AnswerGenerator < AbstractGenerator
  def initialize(arguments)
    super arguments
    @answer_limit      = arguments[:answer_limit] || 3
    @placeholder_field = arguments[:placeholder_field] || (fail ArgumentError, 'placeholder field is required')
    @answer_field      = arguments[:answer_field] || (fail ArgumentError, 'answer field is required')
  end

  def generate(query)
    @locations = Place.get_locations_without key: :city, place: @location
    @answers = Set.new

    @locations.each do |location|
      query[@placeholder_field] = location[:city]
      response = fire_query query
      answer = response[@answer_field]
      @answers.add answer
    end
    @answers
  end
end
