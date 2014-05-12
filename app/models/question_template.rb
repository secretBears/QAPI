class QuestionTemplate < ActiveRecord::Base
  has_many :questions
  has_many :question_placeholders

  validates :question, :query,  presence: true
end
