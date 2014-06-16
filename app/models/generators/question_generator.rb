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

  # TODO: use normal args - to pass everything in one hash was the worst idea ever and is unusable
  def initialize(arguments)
    @template = arguments[:template] || (fail ArgumentError, "template is required")
    @place    = arguments[:place]    || (fail ArgumentError, "place is required")
    @query    = @template.query
  end

  def question(answer_length = 4)
    place                 = @place.city # TODO: should also use country and state
    questions_with_answer = get_question_with_answer place

    questions_with_answer.map do |question_with_answer|
      question             = question_with_answer[:question]
      right_answer         = question_with_answer[:answer]
      wrong_answers        = AnswerGenerator.get_answers @query, right_answer

      answers = {}
      answers[right_answer] = true

      # TODO: can be refactored because we can now pass the right answer to get generator
      wrong_answers.each do |key, _value|
        answers[key] = false unless answers.key? key
        break if answers.length == answer_length
      end
      db_entry = Question.generate! question, answers, @place, @template
      db_entry[:id]
    end
  end

  # TODO: rename to get_questions_with answer
  def get_question_with_answer(location)
    placeholders = extract_placeholders
    results_with_answer = Array.wrap( @query.results_for location )

    results_with_answer.map do |result_with_answer|
      {
        answer:   result_with_answer[:answer],
        question: (replace_placeholder placeholders, result_with_answer[:result])
      }
    end
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
