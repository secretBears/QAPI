class QuestionsController < ApplicationController
  respond_to :json
  before_action :set_question, only: [:show]
  before_action :restrict_access
  before_action :increment_requests

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

  def increment_requests
    @current_user.api_key.requests += 1
    @current_user.api_key.save
  end
end
