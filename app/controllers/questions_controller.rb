class QuestionsController < ApplicationController
  respond_to :json
  before_action :set_question, only: [:show]

  def show

  end

  def show_lat_lng
    @question = QAPIGenerator.get lat_long_params[:latitude], lat_long_params[:longitude]
    render 'show'
  end

  # GET /api/
  def random
    @question = QAPIGenerator.random
    render 'show'
  end

  private
  def set_question
    @question = Question.find(params[:id])
  end

  def lat_long_params
    params.require :latitude
    params.require :longitude
    params.permit :latitude, :longitude
  end
end
