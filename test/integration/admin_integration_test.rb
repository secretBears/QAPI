class AdminIntegrationTest < ActionDispatch::IntegrationTest
  test "hallo" do
    Capybara.current_driver = Capybara.javascript_driver
    visit '/'
  end
end
