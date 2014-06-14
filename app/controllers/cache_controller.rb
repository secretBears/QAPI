class CacheController < ApplicationController
  before_action :authorize_admin
  after_action :render_nothing, except: [:index]

  def index
  end

  def clear_all
    Cache.clear_all
  end

  def clear_all_questions
    Cache.clear_all_questions
  end

  def clear_all_places
    Cache.clear_all_places
  end

  def clear_questions_from_template
    Cache.clear_questions_from_template question_template_params[:template_id]
  end

  private
  def authorize_admin
    authorize! :manage, :all
  end

  def question_template_params
    params.require(:template_id).permit(:template_id)
  end

  def render_nothing
    render nothing: true
  end
end
