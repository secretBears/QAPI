class ProblemValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return true if Report.valid_problems.include?(value)
    record.errors[attribute] << (options[:message] || "is not a valid problem")
  end
end
