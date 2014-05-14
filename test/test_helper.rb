ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'capybara_helper'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!
end
