class Question < ActiveRecord::Base
  has_many :answers, dependent: :delete_all
  belongs_to :place
  belongs_to :question_template

  validates :question, presence: true, uniqueness: true

  # this function will generate the questions
  def self.generate_questions
    puts "generate_questions - not implemented"
  end
end
