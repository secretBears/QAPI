class StaticController < ApplicationController
  def index
    render "logs" if current_user
  end
end
