require 'QAPI/exceptions'

class Admin::ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  rescue_from Exceptions::PlaceNotFound, with: :render_error
  rescue_from ActiveRecord::RecordNotFound, with: :render_error

  private
  def render_error(message)
    render template: 'layouts/error', formats: 'json', locals: {message: message.to_s}, status: 404
  end

  protect_from_forgery with: :exception

  before_action :authenticate_user!
end
