class AnswerGenerator < AbstractGenerator
  def initialize(arguments)
    super arguments
    @answer_limit = arguments[:answer_limit] || 3
  end

  def generate(query)
    @locations ||= Place.get_locations_without @answer_limit, 'Salzburg'
  end
end
