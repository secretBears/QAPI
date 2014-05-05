class QuestionTemplate < ActiveRecord::Base
  has_many :questions
  has_many :question_placeholders

  validates :question,  presence: true

  def self.generate(place)
    qg = QuestionGenerator.new
    Quetion.create(question: qg.question)
  end

  def self.generate_question(template_id, place_id)
    question    = QuestionTemplate.find template_id
    placeholders = QuestionPlaceholder.where question_template_id: template_id

    # TODO: refactor and put in question placeholder
    tmp = {}
    placeholders.each do |placeholder|
      tmp[placeholder['key']] = placeholder['value']
    end
    placeholders = tmp

    question.replace_placeholder placeholders
  end

  def replace_placeholder(replace)
    question  = self.question
    question.gsub regex_placeholder, replace
  end

  private
  def extract_placeholder
    question = self.question
    question.scan(regex_placeholder).flatten
  end

  def regex_placeholder
    Regexp.new '\?\S*'
  end
end
