class QuestionsController < ApplicationController
  respond_to :json

  # GET /api/question
  def show_random
    @question = Question.random_question
    render 'show'
  end

  def show_lat_long
    @question = Question.find_by_lat_long lat_long_params

    unless @question.nil?
      render 'show'
    else
      render_error('no result')
    end
  end


  private
  def lat_long_params
    params.require :latitude
    params.require :longitude
    params.permit :latitude, :longitude
  end
end
