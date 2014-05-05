class Question < ActiveRecord::Base
  has_many :answers, dependent: :delete_all
  belongs_to :place
  belongs_to :question_template
  validates :question, presence: true, uniqueness: true

  def self.get_from_lat_long(args)
    place = Place.geolocate_from_latlong args[:latitude], args[:longitude]
    questions = Question.where place_id: place.id
  end

  def self.get(id)
    Question.find id
  end

  def self.random_question
    random_id = Random.rand 1..Question.count

    if (Random.rand 0..1) > 0
      Question.where("id >= " + random_id.to_s).first
    else
      Question.where("id <= " + random_id.to_s).last
    end
  end

  # this function will generate the questions
  def self.generate_questions
    puts "generate_questions - not implemented"
  end
end
