# QAPIGenerator.rb
#
# The QAPIGenerator Class is a none ActiveRecord Class which is used to
# generate questions and save the questions to the database.
# It also determines if a question should be generated by freebase
# of if it should use an already saved question.
#
# Usage:
# Basic usage returns a random question to a given location
#
# generator = QAPIGenerator.new(123, 321)
# question  = generator.get
#
# For random question generation there is a static get method
# which results in the same way as the example above
#
# question = QAPIGenerator.get(123, 321)
#
# there is also a member where you can specify questions and all other things on your own
# this member is used by the backend for the preview of the template. This should not
# be used by the real application because it does not cache the result
#
# QAPIGenerator.get_test(
#   mql: 'mql query',
#   answer_property: 'json path to answer',
#   location_property: 'json path to location',
#   template_property: 'the template for the question',
#   place_id: 'id of the place'
# )

class QAPIGenerator
  # static member for getting a question to a given position
  #
  #   question = QAPIGenerator.get 12, 23
  def self.get(lat, lng)
    generator = QAPIGenerator.new lat, lng
    generator.get
  end

  # get a question from a template_id and a place_id
  # @deprecated
  #   QAPIGenerator.get_from_ids 1, 3
  def self.get_from_ids(place_id, template_id)
    Question.where(question_template_id: template_id, place_id: place_id)
  end

  # TODO: write documentation
  def self.get_test(params)
    ActiveRecord::Base.transaction do
      query = Query.create_from_params! params
      template = QuestionTemplate.create_from_params! params, query

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

  def initialize(lat, lng)
    @place = Place.get lat, lng
  end

  # gets a question including answers
  #
  #   generator = QAPIGenerator.new(12, 32)
  #   question = generator.get
  #
  # additionaly a template can be passed
  #
  #   template = QuestionTemplate.first
  #   question = generator.get template
  # TODO: refactor templates to get_from_templates
  # TODO: refactor change name to a meaningful
  def get(templates = nil)
    templates = QuestionTemplate.random if templates.nil? || templates.empty?

    questions = Question.where(question_template_id: templates, place: @place)
    return questions unless questions.blank?

    QuestionGenerator.generate! templates, @place
  end
end
