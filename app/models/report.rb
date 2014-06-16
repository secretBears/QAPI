class Report < ActiveRecord::Base
  belongs_to :question

  validates :comment, :problem, :question_id, presence: true
  validates :problem, problem: true

  def self.valid_problems
    ['Incorrect answer', 'Question not related to location', 'Other problem']
  end
end
