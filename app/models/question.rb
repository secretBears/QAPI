class Question < ActiveRecord::Base
  has_many :answers, dependent: :delete_all
  belongs_to :place
  belongs_to :question_template

  validates :question, presence: true, uniqueness: true

  def self.find_by_lat_long(args)
    place = Place.geolocate_from_latlong args[:latitude], args[:longitude]
    @question = Question.find_by(place_id: place.id)
  end

  # this function will generate the questions
  def self.generate_questions
    puts "generate_questions - not implemented"
  end
end
