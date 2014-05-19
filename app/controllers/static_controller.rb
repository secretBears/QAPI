class StaticController < ApplicationController
  authorize_user!
  
  def index
    render "logs" if current_user
  end
end
