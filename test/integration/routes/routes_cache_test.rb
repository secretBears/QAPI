require 'test_helper'

class RoutesCacheTest < ActionDispatch::IntegrationTest
  test 'should get cache clear all' do
    assert_routing({
                       path: '/cache/clear/all',
                       method: :get
                   }, {
                       controller: 'cache',
                       action: 'clear_all'
                   })
  end

  test 'should get cache clear all places' do
    assert_routing({
                       path: '/cache/clear/all/places',
                       method: :get
                   }, {
                       controller: 'cache',
                       action: 'clear_all_places'
                   })
  end

  test 'should get cache clear clear questions from template' do
    assert_routing({
                       path: '/cache/clear/question-from-template/5',
                       method: :get
                   }, {
                       controller: 'cache',
                       action: 'clear_questions_from_template',
                       template_id: 5.to_s
                   })
  end
end