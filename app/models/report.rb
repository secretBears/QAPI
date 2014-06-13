class ProblemValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless Report.valid_problems.include?(value)
      record.errors[attribute] << (options[:message] || "is not a valid problem")
    end
  end
end

class Report < ActiveRecord::Base
  belongs_to :question

  validates_presence_of :comment, :problem, :question_id
  validates :problem, problem: true

  def self.valid_problems
    ['Incorrect answer', 'Question not related to location', 'Other problem']
  end
end
