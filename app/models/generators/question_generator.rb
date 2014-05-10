class QuestionGenerator
  def initialize(arguments)
    @query    = arguments[:query]           || (fail ArgumentError, "query is required")
    @location = arguments[:location].freeze || (fail ArgumentError, "location is required")
    @template = arguments[:template].freeze || (fail ArgumentError, "template is required")
  end

  def get(location)
    placeholders = extract_placeholder
    replace      = @query.get location
    question     = replace_placeholder placeholders, replace
    return question if question

    nil
  end

  private
  def extract_placeholder
    @template.scan(regex_placeholder).flatten
  end

  def replace_placeholder(placeholders, replace)
    question = @template.dup
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
    Regexp.new '\?\S*'
  end
end
