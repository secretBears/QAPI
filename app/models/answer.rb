class Answer < ActiveRecord::Base
  belongs_to :question
  validates :question, presence: true

  # validates_presence_of :question
  # validates_presence_of :is_true
end
