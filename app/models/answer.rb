class Answer < ActiveRecord::Base
  belongs_to :question

  validates :question_id, presence: true
  validates :answer, presence: true
  validates :is_true, inclusion: {in: [true, false]}
end
