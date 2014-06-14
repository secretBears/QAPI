class QuestionGenerator
  def self.generate!(templates, place)
    question_ids = templates.map do |template|
      generator = QuestionGenerator.new(
          template: template,
          place: place
      )
      generator.question
    end
    Question.find(question_ids)
  end

  # TODO: use normal args
  def initialize(arguments)
    @template = arguments[:template] || (fail ArgumentError, "template is required")
    @place    = arguments[:place]    || (fail ArgumentError, "place is required")
    @query    = @template.query
  end

  def question
    place     = @place.city # TODO: should also use country and state
    question_with_answer = get_question_with_answer place
    question             = question_with_answer[:question]
    right_answer         = question_with_answer[:answer]
    wrong_answers        = get_wrong_answers place

    answers = {}
    wrong_answers.each do |key, _value|
      answers[key] = false
    end
    answers[right_answer] = true

    db_entry = Question.generate! question, answers, @place, @template
    db_entry[:id]
  end

  def get_question_with_answer(location)
    placeholders = extract_placeholders
    result_with_answer = @query.results location

    {
      answer:   result_with_answer[:answer],
      question: (replace_placeholder placeholders, result_with_answer[:result])
    }
  end

  def get_wrong_answers(location)
    places = Place.get_without key: :city, place: location
    locations = places.map! { |location| location.city }

    AnswerGenerator.get locations, @query
  end

  # @deprecated
  def self.get(query, template, location)
    generator = QuestionGenerator.new(
        query: query,
        template: template
    )
    generator.get_question_with_answer location
  end

  private
  def extract_placeholders
    @template.question.scan(regex_placeholder).flatten
  end

  def replace_placeholder(placeholders, replace)
    question = @template.question.dup
    placeholders.each do |placeholder|
      index = placeholder.gsub(/\?/, '')
      regex = escape_regex placeholder
      question.gsub! regex, replace[index]
    end
    question
  end

  def escape_regex(name)
    /#{Regexp.quote(name)}/
  end

  def regex_placeholder
    Regexp.new '\?\w+'
  end
end
