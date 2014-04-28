class QuestionTemplate < ActiveRecord::Base
  has_many :questions
  has_many :question_placeholders

  validates :question,  presence: true

  private
  def extract_placeholder
    question = self.question
    question.scan(regex_placeholder).flatten
  end

  def replace_placeholder(replace)
    question  = self.question
    question.gsub regex_placeholder, replace
  end

  def regex_placeholder
    Regexp.new '\?\S*'
  end
end
