class Question < ActiveRecord::Base
  def self.random_question
    Question.order("RANDOM()").first
  end
end
