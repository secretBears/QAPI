include ActionController::MimeResponds

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  rescue_from Exceptions::PlaceNotFound, with: :render_error
  rescue_from ActiveRecord::RecordNotFound, with: :render_error
  rescue_from Exceptions::InvalidTokenError, with: :render_authentication_error

  private
  def render_error(message)
    render template: 'layouts/error', formats: 'json', locals: {message: message.to_s}, status: 404
  end

  def render_authentication_error(message)
    render template: 'layouts/error', formats: 'json', locals: {message: message.to_s}, status: 401
  end

  protect_from_forgery with: :exception

  def restrict_access
    if has_token
      fail Exceptions::InvalidTokenError unless restrict_access_by_params
      @current_user = @api_key.user if @api_key
    else
      authorize! :manage, :all
      @current_user = current_user
    end
  end

  def has_token
    params[:token] != nil
  end

  def restrict_access_by_params
    return true if @api_key

    @api_key = ApiKey.find_by_token(params[:token])
  end
end
