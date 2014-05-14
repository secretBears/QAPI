module Exceptions
  class PlaceNotFound < StandardError; end
  class QueryNotFound < StandardError; end
  class QuestionNotFound < StandardError; end
  class InitializationError < StandardError; end
  class InvalidTokenError < StandardError; end
end
