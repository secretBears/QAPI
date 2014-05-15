class JsonValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    !!JSON.parse(value)

    rescue
      false
  end
end
