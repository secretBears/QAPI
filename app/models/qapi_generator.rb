class QAPIGenerator
  def initialize(lat, lng)
    @place = Place.geolocate_from_latlong lat, lng
  end

  def get
    templates = QuestionTemplate.random
    location  = @place.city # TODO: should also use country and state

    templates.map do |template|
      query = template.query

      question  = QuestionGenerator.get query, template.question, location
      right_answer = AnswerGenerator.get location, query

      wrong_cities = Place.get_locations_without key: :city, place: location
      wrong_cities = Place.as_array wrong_cities, :city

      wrong_answers = AnswerGenerator.get wrong_cities, query

      answers = AnswerGenerator.shuffle_answers right_answer, wrong_answers

      format_question question, answers
    end
  end

  private
  def get_question(generator, location)
    generator.get location
  end

  def format_question(question, answers)
    {
        question: question,
        answers: answers
    }
  end
end
