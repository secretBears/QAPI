class AbstractGenerator
  def initialize(arguments)
    @location = arguments[:location] || (fail ArgumentError, "location is required")
    @template = arguments[:template] || (fail ArgumentError, "template is required")
  end
end
