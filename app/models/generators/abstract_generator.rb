class AbstractGenerator
  def initialize(arguments)
    @query    = arguments[:query]           || (fail ArgumentError, "query is required")
  end
end
