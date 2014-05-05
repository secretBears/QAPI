class AbstractGenerator
  def initialize(arguments)
    @location = arguments[:location].freeze || (fail ArgumentError, "location is required")
    @template = arguments[:template].freeze || (fail ArgumentError, "template is required")
  end
end
