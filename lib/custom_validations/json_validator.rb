class JsonValidator < ActiveModel::EachValidator
  def validate_each(_object, _attribute, value)
    !!JSON.parse(value)
    rescue
      false
  end
end
