class JsonValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    begin
      !!JSON.parse(value)
    rescue
      false
    end
  end
end
