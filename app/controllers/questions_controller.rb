class QuestionsController < ApplicationController
  respond_to :json
  before_action :set_question, only: [:show]

  def show
  end

  # GET /api/question
  def show_random
    @question = Question.random_question
    render 'show'
  end

  def show_lat_long
    @question = Question.find_by_lat_long lat_long_params

    if @question.nil?
      render_error('no result')
    else
      render 'show'
    end
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
