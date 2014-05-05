require 'test_helper'

class RoutesTest < ActionDispatch::IntegrationTest
  test 'test output format' do
    assert_generates '/api',     controller: 'questions', action: 'show_random', format: :json
  end

  test 'should get show_lat_long' do
    assert_generates('/api/47.8094888/13.0550007',
                     controller: 'questions',
                     action: 'show_lat_long',
                     latitude: 47.8094888,
                     longitude: 13.0550007,
                     format: :json
    )
  end
end
