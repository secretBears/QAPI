class CacheController < ApplicationController
  before_action :authorize_admin
  # after_action :redirect_back, except: [:index]

  def index
  end

  def clear_all
    Cache.clear_all
    redirect_to :back
  end

  def clear_all_questions
    Cache.clear_all_questions
    redirect_to :back
  end

  def clear_all_places
    Cache.clear_all_places
    redirect_to :back
  end

  def clear_questions_from_template
    Cache.clear_questions_from_template question_template_params[:template_id]
    redirect_to :back
  end

  private
  def authorize_admin
    authorize! :manage, :all
  end

  def question_template_params
    params.require(:template_id).permit(:template_id)
  end
end
