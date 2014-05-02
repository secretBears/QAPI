class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  def not_found
    fail ActionController::RoutingError.new('Not Found'), 'not found'
  end

  protect_from_forgery with: :exception
end
