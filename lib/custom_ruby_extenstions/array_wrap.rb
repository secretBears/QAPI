# wraps an none array element to an array unless it is  already an array

class Array
  def self.wrap(element)
    [element] unless element == Array
  end
end