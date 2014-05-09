class AbstractGenerator
  def initialize(arguments)
    @query    = arguments[:query]           || (fail ArgumentError, "query is required")
  end

  private
  def fire_query(query)
    result = FreebaseAPI.session.mqlread query
    fail Exceptions::QueryNotFound, 'No Results for query' if result.nil?
    result
  end
end
