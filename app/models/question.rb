class Question < ActiveRecord::Base
  include ActiveSupport::Rescuable

  has_many :answers, dependent: :delete_all
  belongs_to :place
  belongs_to :question_template
  validates :question, presence: true, uniqueness: true

  def self.get_from_lat_long(args)
    # TODO: use sql query to get questions
    place = Place.geolocate_from_latlong args[:latitude], args[:longitude]
    Question.where place_id: place.id
  end

  def self.get(id)
    Question.find id
  end

  def self.random_question
    Question.order('RANDOM()').first
  end
end
