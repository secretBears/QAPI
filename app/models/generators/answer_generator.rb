require 'set'
class AnswerGenerator < AbstractGenerator
  def initialize(arguments)
    super arguments
    @answer_limit = arguments[:answer_limit] || 3
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

  def get(locations)
    locations = [locations] if locations.class == String
    answers = []
    locations.each do |location|
      answers.push((@query.get location)['answer'])
    end
    answers
  end
end
