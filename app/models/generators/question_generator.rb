class QuestionGenerator < AbstractGenerator
  def initialize(arguments)
    super arguments
  end

  def generate(query)
    placeholders = extract_placeholder
    replace      = fire_query query
    question     = replace_placeholder placeholders, replace
    return question if question

    nil
  end

  private
  def fire_query(query)
    result = FreebaseAPI.session.mqlread query
    fail Exceptions::QueryNotFound, 'No Results for query' if result.nil?
    result
  end

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