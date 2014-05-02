class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  def not_found
    fail ActionController::RoutingError.new('Not Found'), 'not found'
    rescue
      render file: 'public/404.html', status: :not_found, layout: false
  end

  protect_from_forgery with: :exception
end
