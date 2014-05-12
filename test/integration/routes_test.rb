require 'test_helper'

class RoutesTest < ActionDispatch::IntegrationTest
  test 'should get show_lat_long' do
    assert_generates('/api/47.8094888/13.0550007',
                     controller: 'questions',
                     action: 'show_lat_long',
                     latitude: 47.8094888,
                     longitude: 13.0550007,
                     format: :json
    )
  end

  test 'should get root page in html' do
    assert_generates('/',
                     controller: 'static',
                     action: 'index'
    )
  end

  test 'should get edit of admin question template' do
    assert_generates('/admin/question_templates/1',
                      controller: 'admin/question_templates',
                      action: 'edit')
  end
end
