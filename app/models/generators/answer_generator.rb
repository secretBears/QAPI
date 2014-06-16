# answer_generator.rb
# is used to generate answers to a given query

require 'set'
class AnswerGenerator
  attr_accessor :answers

  # TODO: use normal parameters - I really don't know in which stupid gem i found that (this is so annoying to use because you don't know which params to pass)
  def initialize(arguments)
    @query        = arguments[:query]        || (fail ArgumentError, "query is required")
    @answer_limit = 4    # TODO: should be placed in global config
    @answers = Set.new
  end

  # gets answers to a given query
  # an additional without_answer can be passed which will not be a part of the returned answers
  def self.get_answers(query, without_answer = nil)
    generator = AnswerGenerator.new query: query
    generator.answers.add without_answer unless without_answer.nil?
    generator.find_answers_from_db
    generator.find_answers_from_query
    generator.answers.delete without_answer unless without_answer.nil?
    generator.answers.to_a
  end

  # Searches the database for answers
  # Returns set with unique answers
  def find_answers_from_db
    answers_from_db = get_questions_from_db
    answers_from_db.each do |answer_from_db|
      @answers.add answer_from_db[:answer]
      break if @answers.length >= @answer_limit
    end
    @answers.to_a
  end

  # fires a query to the semantic database with a different location
  # if not enough answers are found a next location will be used to get answers
  def find_answers_from_query
    locations = get_places_from_db

    locations.each do |location|
      query_answers  = @query.results location[:city]
      query_answers.each do |query_answer|
        @answers.add query_answer[:answer]
        # TODO: I don't know if it's possible to break out of two loops at once

        break if @answers.length >= @answer_limit
      end
      break if @answers.length >= @answer_limit
    end
    @answers.to_a
  end

  def get(locations)
    locations = Array(locations) if locations.class == String
    locations.map do |location|
      answers  = @query.results_for location
      answers.map do |answer|
        answer[:answer]
      end
    end
  end

  # @deprecated
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

  private
  def get_questions_from_db
    Answer.select(:answer).distinct.where(
        question_id: Question.where(
            question_template_id: QuestionTemplate.where(
                query_id: @query
            )
        )
    )
    # TODO: I don't know why the nested example is working and this is not working
    # templates = QuestionTemplate.find_by_query(@query)
    # questions = Question.find_by_question_templates(templates)
    # Answer.select(:answer).distinct.limit(@answer_limit).find_by_questions(questions)
  end

  def get_places_from_db
    Place.all.limit @answer_limit
  end
end
