class Question < ActiveRecord::Base
  include ActiveSupport::Rescuable

  has_many :answers, dependent: :delete_all
  belongs_to :place
  belongs_to :question_template
  validates :question, presence: true, uniqueness: true

  def self.get_from_lat_long(args)
    # TODO: use sql query to get questions
    place = Place.geolocate_from_latlong args[:latitude], args[:longitude]
    questions = Question.where place_id: place.id
    generate_questions if questions.empty?
    questions
  end

  def self.get(id)
    Question.find id
  end

  def self.random_question
    Question.order('RANDOM()').first
  end

  # this function will generate the questions
  def self.generate_questions
    puts "generate_questions - not implemented"
  end
end
