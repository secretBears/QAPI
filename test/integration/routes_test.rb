require 'test_helper'

class RoutesTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    assert_generates('/',
                     controller: 'static',
                     action: 'index'
    )
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

  test 'should get root page in html' do
    assert_generates('/',
                     controller: 'static',
                     action: 'index'
    )
  end

  test 'should get edit of admin question template' do
    assert_generates('/admin/question_templates/1',
                     controller: 'admin/question_templates',
                     action: 'edit',
                     id: '1'
    )
  end

  test 'should get all api paths' do
    assert_routing({
                       path: 'api',
                       method: :get
                   }, {
                       controller: 'questions',
                       action: 'random',
                       format: 'json'
                   })

    assert_routing({
                       path: 'api/47.8094888/13.0550007',
                       method: :get
                   }, {
                       controller: 'questions',
                       action: 'show_lat_long',
                       latitude: "47.8094888",
                       longitude: "13.0550007",
                       format: 'json'
                   })

    assert_routing({
                       path: 'api/47.8094888/13.0550007/2',
                       method: :get
                   }, {
                       controller: 'questions',
                       action: 'show_lat_long',
                       format: 'json',
                       latitude: "47.8094888",
                       longitude: "13.0550007",
                       count: "2"
                   })
  end
end
