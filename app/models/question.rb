class Question < ActiveRecord::Base
  has_many :answers
  validates :question, presence: true, uniqueness: true

  def self.get(id)
    Question.find id
    rescue ActiveRecord::RecordNotFound
      ({
        error: '404',
        error_desc: 'not found'
      })
  end

  def self.random_question
    Question.order("RANDOM()").first
  end
end
