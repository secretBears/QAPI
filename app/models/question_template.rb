class QuestionTemplate < ActiveRecord::Base
  has_many :questions

  validates :question,  presence: true

  def extract_params_from_question

  end
end
