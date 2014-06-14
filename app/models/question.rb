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
    # fail Exceptions::InvalidAmountOfAnswers if (answers.count-1) != QAPI::Application.config.answers_amount

    question_obj = Question.find_by(
        place:             place,
        question:          question,
        question_template: template
    )

    return question_obj unless question_obj.blank?


    question = Question.create!(
      place:             place,
      question:          question,
      question_template: template
    )

    answers.each do |answer, is_true|
      question.answers.create(
          answer: answer,
          is_true: is_true
      )
    end
    question.save!
    question
  end

  def self.random
    Question.find 1 # TODO: randomize
  end
end
