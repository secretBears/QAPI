class QuestionTemplate < ActiveRecord::Base
  has_many :questions
  has_many :question_placeholders
  belongs_to :query

  validates :question, :query,  presence: true

  def self.random(limit = 1)
    QuestionTemplate.order('random()').limit(limit)
  end
end
