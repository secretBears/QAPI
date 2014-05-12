class QAPIGenerator
  def initialize(lat, lng)
    @place = Place.geolocate_from_latlong lat, lng
  end

  def get
    # template = QuestionTemplate.random
    # puts template.query

    'lalal'
  end

end
