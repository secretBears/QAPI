class Question < ActiveRecord::Base
  has_many :answers




  def self.random_question
    Question.order("RANDOM()").first
  end
end
