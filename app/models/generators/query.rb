class Query
  attr_reader :location_property, :answer_property
  def initialize(arguments)
    @query_hash        = arguments[:query_hash]               || (fail ArgumentError, "query hash is required")
    @location_property = arguments[:location_property].freeze || (fail ArgumentError, "location property is required")
    @answer_property   = arguments[:answer_property].freeze   || (fail ArgumentError, "answer property is required")
  end

  def get(location)
    query = @query_hash.clone
    query[@location_property] = location
    query
  end
end
