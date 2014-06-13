class QuestionsController < ApplicationController
  respond_to :json
  before_action :set_question, only: [:show]
  before_action :check_authorization
  before_action :increment_requests

  def show
    # TODO: show should use template from index
  end

  def show_lat_lng
    @questions = QAPIGenerator.get lat_long_params[:latitude], lat_long_params[:longitude]
    render 'index'
  end

  def show_from_template_and_place
    params = tpl_place_params
    @questions = QAPIGenerator.get_from_ids params[:place_id], params[:template_id]
    render 'index'
  end

  # GET /api/
  def random
    @questions = QAPIGenerator.random
    render 'index'
  end

  # get /api/test/:location_id/?:location_property&
  def test_query
    params_decoded = Misc.decode_params test_query_params
    @questions = QAPIGenerator.get_test params_decoded
    render json: @questions
  end

  private

  def check_authorization
    authorize! :manage, QuestionTemplate
    rescue CanCan::AccessDenied
      validate_token
  end

  def set_question
    @questions = Question.find(params[:id])
  end

  def lat_long_params
    params.require :latitude
    params.require :longitude
    params.require :longitude
    params.permit :latitude, :longitude, :count
  end

  def test_query_params
    params.require :place_id
    params.require :location_property
    params.require :answer_property
    params.require :template_property
    params.require :token
    params.require :mql
    params.permit :place_id, :location_property, :answer_property, :token, :mql, :template_property
  end

  def increment_requests
    @current_user.api_key.requests += 1
    @current_user.api_key.save
  end

  def tpl_place_params
    params.require :template_id
    params.require :place_id
    params.permit :template_id, :place_id
  end
end
