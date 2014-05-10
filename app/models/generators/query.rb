class Query
  attr_reader :location_property, :answer_property
  alias_method :location, :location_property

  def initialize(arguments)
    @query_hash        = arguments[:query_hash]               || (fail ArgumentError, "query hash is required")
    @location_property = arguments[:location_property].freeze || (fail ArgumentError, "location property is required")
    @answer_property   = arguments[:answer_property].freeze   || (fail ArgumentError, "answer property is required")
  end

  def get(location)
    query = @query_hash.clone
    query[@location_property] = location
    result = fire_query query

    result['answer'] = result[@answer_property]
    result.delete(@answer_property)
    result
  end

  private
  def fire_query(query)
    result = FreebaseAPI.session.mqlread query
    fail Exceptions::QueryNotFound, 'No Results for query' if result.nil?
    result
  end
end
