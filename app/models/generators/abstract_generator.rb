class AbstractGenerator
  def initialize(arguments)
    @location = arguments[:location].freeze || (fail ArgumentError, "location is required")
    @template = arguments[:template].freeze || (fail ArgumentError, "template is required")
    # @query    = arguments[:query]           || (fail ArgumentError, "query is required")
  end

  private
  def fire_query(query)
    result = FreebaseAPI.session.mqlread query
    fail Exceptions::QueryNotFound, 'No Results for query' if result.nil?
    result
  end
end
