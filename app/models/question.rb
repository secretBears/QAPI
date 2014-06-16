class Question < ActiveRecord::Base
  has_many :answers, dependent: :delete_all

  belongs_to :place
  belongs_to :question_template

  validates :place,    presence: true
  validates :question, presence: true # uniqueness: true # TODO: in some cases this validation fails
  validates :question_template, presence: true

  scope :find_by_question_templates, -> (templates) {find_by(question_template_id: templates) }

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

    Question.create_question! question, answers, place, template
  end

  def self.create_question!(question, answers, place, template)
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
    question
  end
end
