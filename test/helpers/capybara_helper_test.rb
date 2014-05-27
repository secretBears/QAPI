require 'capybara/rails'

class ActionDispatch::IntegrationTest
  include Capybara::DSL
end
