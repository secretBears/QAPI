class QuestionsController < ApplicationController
  respond_to :json
  before_action :set_question, only: [:show]

  def show

  end

  # GET /api/
  def random
    @question = Question.random
    render 'show'
  end

  def show_lat_long
    qg = QAPIGenerator.new(lat_long_params[:latitude], lat_long_params[:longitude])
    @question = qg.get
    render json: @question
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
