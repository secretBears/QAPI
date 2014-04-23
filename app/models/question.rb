class Question < ActiveRecord::Base
  has_many :answers
  #validates :name, presence: true

  def self.random_question
    Question.order("RANDOM()").first
  end
end
