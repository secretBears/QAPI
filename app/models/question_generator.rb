class QuestionGenerator
  def initialize(arguments)
    @location = arguments[:location] || (fail ArgumentError, "location is required")
  end

  def generate_question

  end

  private
  def fire_query(query)
    result = FreebaseAPI.session.mqlread query
    fail Exceptions::QueryNotFound, 'No Results for query' if result.nil?
    result
  end
end
