require 'QAPI/exceptions'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  rescue_from Exceptions::PlaceNotFound do |exception|
    render template: 'layouts/error', formats: 'json', locals: {message: 'Place not found'}, status: 404
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render template: 'layouts/error', formats: 'json', locals: {message: 'Record not found'}, status: 404
  end

  # rescue_from Exceptions::PlaceNotFound, with: render_error, message: "test"
  #
  # def render_error(*args)
  #   puts args.inspect
  #   render :template => 'layouts/error', formats: 'json', locals: {message: 'Place not found'}, status: 404
  # end

  protect_from_forgery with: :exception
end
