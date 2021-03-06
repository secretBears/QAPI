require 'test_helper'
# TODO: tests for routes should be seperated into files according to their scope
# TODO: for example /api should get the file routes_api_test.rb
# TODO: or routes_misc_test.rb

class RoutesTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    assert_routing({
                     path: '/',
                     method: :get
                   }, {
                     controller: 'static',
                     action: 'index'
                   })
  end

  test 'should get /api/:lat/:lng' do
    assert_routing({
                     path: 'api/47.8094888/13.0550007',
                     method: :get
                   }, {
                     controller: 'questions',
                     action: 'index_lat_lng',
                     lat: "47.8094888",
                     lng: "13.0550007",
                     format: 'json'
                   })
  end

  test 'should get /api/:lat/:lng with negativ coords' do
    assert_routing({
                     path: 'api/-47.8094888/-13.0550007',
                     method: :get
                   }, {
                     controller: 'questions',
                     action: 'index_lat_lng',
                     lat: "-47.8094888",
                     lng: "-13.0550007",
                     format: 'json'
                   })
  end

  test 'should get /api/:lat/:lng/:count' do
    assert_routing({
                     path: 'api/47.8094888/13.0550007/2',
                     method: :get
                   }, {
                     controller: 'questions',
                     action: 'index_lat_lng',
                     format: 'json',
                     lat: "47.8094888",
                     lng: "13.0550007",
                     count: "2"
                   })
  end

  test 'should get /api/:lat/:lng/:count with negative coords' do
    assert_routing({
                     path: 'api/-47.8094888/-13.0550007/2',
                     method: :get
                   }, {
                     controller: 'questions',
                     action: 'index_lat_lng',
                     format: 'json',
                     lat: "-47.8094888",
                     lng: "-13.0550007",
                     count: "2"
                   })
  end

  test 'should get edit of question template' do
    assert_generates('question_templates/1',
                     controller: 'question_templates',
                     action: 'edit',
                     id: '1'
    )
  end

  test 'should get bypassed route' do
    assert_generates('/api/bypass/1/1',
                     controller: 'questions',
                     action: 'show_from_template_and_place',
                     place_id: 1,
                     template_id: 1
    )
  end

  test 'should get about' do
    assert_generates('/imprint',
                     controller: 'static',
                     action: 'imprint'
    )
  end
end
