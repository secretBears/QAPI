class QuestionTemplate < ActiveRecord::Base
  has_many :questions
  has_many :question_placeholders
  belongs_to  :query

  validates :question,  presence: true
  validates :query,  presence: true
end
