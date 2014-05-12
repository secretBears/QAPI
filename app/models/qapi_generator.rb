class QAPIGenerator
  def initialize(lat, lng)
    @place = Place.geolocate_from_latlong lat, lng
  end

  def get
    templates = QuestionTemplate.random
    # location  = @place.city # TODO: should also use country and state
    questions = []

    templates.each do |template|
      # query = template.query
      #
      # QuestionGenerator
      #
      #
      #
      #
      #
      # answer_g   = AnswerGenerator.new query: query
      # answer_locations = Place.get_locations_without key: :city, place: location
      #
      # question = question_g.get location
      #
      # answers = []
      # answer_locations.each do |answer_location|
      #   answers.push(
      #       answers: (answer_g.get answer_location)
      #   )
      # end
      # questions.push(
      #     question: question,
      #     answers: answers
      # )
    end
    questions
  end

  private
  def get_question(generator, location)
    generator.get location
  end
end
