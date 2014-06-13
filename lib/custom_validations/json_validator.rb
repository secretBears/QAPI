require 'json'

class JsonValidator < ActiveModel::EachValidator
  def validate_each(_object, _attribute, value)
    JSON.parse(value)
    true
    rescue JSON::ParserError
      false
  end
end
