class QAPIGenerator
  def initialize(lat, lng)
    @place = Place.geolocate_from_latlong lat, lng
  end

  def get
    # templates = QuestionTemplate.random
    # location  = @place.city # TODO: should also use country and state
    # query =
    #
    # templates.each do |template|
    #   #
    #   # question_g = QuestionGenerator.new location: @place
    #   # answer_g   = AnswerGenerator.new
    #   #
    #   # query_result = template.query.get location
    #   # puts query_result
    # end
    #
    #
    #
    'lalal'
  end

end
