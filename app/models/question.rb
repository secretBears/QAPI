class Question < ActiveRecord::Base
  has_many :answers, dependent: :delete_all
  belongs_to :place
  belongs_to :question_template

  validates :question, presence: true, uniqueness: true

  def self.random
    Question.find 1
  end
end
