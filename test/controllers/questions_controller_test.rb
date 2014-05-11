require 'test_helper'
require 'active_model/serializers/json'

class QuestionsControllerTest < ActionController::TestCase
  setup do
    @controller = QuestionsController.new
    @question = Question.first
  end


end
