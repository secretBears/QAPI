require 'QAPI/exceptions'

class Admin::AdminController < ApplicationController
  before_action :authenticate_user!

  layout 'admin'
end
