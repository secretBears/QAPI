class QuestionTemplate < ActiveRecord::Base
  has_many :questions
  validates :question,  presence: true

  def extract_placeholder
    question   = self.question
    question.scan(/\?\S*/).flatten
  end

end
