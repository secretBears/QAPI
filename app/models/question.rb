class Question < ActiveRecord::Base
  has_many :answers, dependent: :delete_all
  belongs_to :place
  belongs_to :question_template

  validates :place,    presence: true
  validates :question, presence: true, uniqueness: true
  validates :question_template, presence: true

  def self.get_from_place(place)
    question = Question.where(place_id: place[:id])
    question unless question.blank?
  end

  def self.generate!(question, answers, place, template)
    fail Exceptions::InvalidAmountOfQuestion if answers.count != QAPI::Application.config.question_amount

    question_obj = Question.create!(
      place:             place,
      question:          question,
      question_template: template
    )

    answers.each do |answer|
      Answer.create!(
          question: question_obj,
          answer: answer[:answer],
          is_true: answer[:is_true]
      )
    end
  end

  def self.random
    Question.find 1 # TODO: randomize
  end
end
