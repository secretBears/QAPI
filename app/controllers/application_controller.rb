include ActionController::MimeResponds

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  rescue_from Exceptions::PlaceNotFound, with: :render_error
  rescue_from ActiveRecord::RecordNotFound, with: :render_error
  rescue_from Exceptions::InvalidTokenError, CanCan::AccessDenied, with: :render_authorization_error

  private
  def render_error(message)
    render template: 'layouts/error', formats: 'json', locals: {message: message.to_s, status: 404}, status: 404
  end

  def render_authorization_error(_message)
    respond_to do |format|
      format.json do
        render template: 'layouts/error', formats: %w(json html), locals: {message: "You are not authorized to access
 this resource",                                                           status: 403},
               status: 403
      end

      format.html do
        redirect_to root_url
      end
    end
  end

  protect_from_forgery with: :exception

  def validate_token
    fail Exceptions::InvalidTokenError unless restrict_access_by_params
    @current_user = @api_key.user if @api_key
  end

  def token?
    !params[:token].nil?
  end

  def restrict_access_by_params
    return true if @api_key

    @api_key = ApiKey.find_by_token(params[:token])
  end
end
