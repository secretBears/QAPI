module Exceptions
  class PlaceNotFound < StandardError
    def exception
      "place not found"
    end
  end
end
