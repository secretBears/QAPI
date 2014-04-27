class QuestionTemplate < ActiveRecord::Base
  has_many :questions

  validates :question,  presence: true
end
