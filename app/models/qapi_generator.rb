class QAPIGenerator
  def initialize(lat, lng)
    @place = Place.get lat, lng
  end

  def get(templates = nil)
    templates = QuestionTemplate.random if templates.nil?
    location  = @place.city # TODO: should also use country and state
    format = nil

    templates.map do |template|
      query = template.query

      question  = QuestionGenerator.get query, template.question, location
      right_answer = AnswerGenerator.get location, query

      wrong_cities = Place.get_without key: :city, place: location
      wrong_cities = Place.as_array wrong_cities, :city

      wrong_answers = AnswerGenerator.get wrong_cities, query

      answers = AnswerGenerator.shuffle_answers right_answer, wrong_answers

      format = format_question question, answers
    end
    format
  end

  def self.get(lat, lng)
    generator = QAPIGenerator.new lat, lng
    generator.get
  end

  def self.get_from_template(place_id, template_id)
    place    = Place.find place_id
    template = QuestionTemplate.find template_id
    generator = QAPIGenerator.new place[:latitude], place[:longitude]
    generator.get([template])
  end

  def self.get_test(params)
    ActiveRecord::Base.transaction do
      query = QAPIGenerator.generate_query_from_params params
      template = QAPIGenerator.generate_template_from_params params, query

      place = Place.find params['place_id']
      generator = QAPIGenerator.new place[:latitude], place[:longitude]

      # TODO: dirty hack to put template in brackets so it is enumurable
      result = generator.get([template])

      # TODO: find a way that we don't have to store the dummy records in the database
      query.destroy!
      template.destroy!
      return result
    end
    nil
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

  # TODO: should be placed in models
  def self.generate_query_from_params(params)
    Query.create!(
        query_hash:  params['mql'],
        answer_property: params['answer_property'],
        location_property: params['location_property']
    )
  end

  def self.generate_template_from_params(params, query)
    QuestionTemplate.create!(
        question: params['template_property'],
        query: query
    )
  end
end
