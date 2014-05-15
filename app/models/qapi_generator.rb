class QAPIGenerator
  def initialize(lat, lng)
    @place = Place.get lat, lng
  end

  def get(templates = nil)
    templates = QuestionTemplate.random if templates.nil?
    location  = @place.city # TODO: should also use country and state

    templates.map do |template|
      query = template.query

      question  = QuestionGenerator.get query, template.question, location
      right_answer = AnswerGenerator.get location, query

      wrong_cities = Place.get_without key: :city, place: location
      wrong_cities = Place.as_array wrong_cities, :city

      wrong_answers = AnswerGenerator.get wrong_cities, query

      answers = AnswerGenerator.shuffle_answers right_answer, wrong_answers

      format_question question, answers
    end
  end

  def self.get(lat, lng)
    generator = QAPIGenerator.new lat, lng
    generator.get
  end

  def self.get_test(params)
    query = Query.create(
      query_hash: params['mql'],
      answer_property: params['answer_property'],
      location_property: params['location_property']
    )
    query.save!



    template = QuestionTemplate.create(
      question: params['template_property'],
      query: query
    )
    template.save!

    place = Place.find params['place_id']
    generator = QAPIGenerator.new place[:latitude], place[:longitude]

    puts generator.get([template]) # dirty hack
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
