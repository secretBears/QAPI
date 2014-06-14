require 'test_helper'

class QAPIGeneratorTest < ActiveSupport::TestCase
  setup do
    @query = Query.find 1
  end

  test "should raise argument error" do
    assert_raise ActiveRecord::UnknownAttributeError do
      Query.new test: 'lalelu'
    end
  end

  test "should not save with non-array hash" do
    non_array_hash = <<-HERE_DOC
  {
    "type": "/music/artist",
    "origin": "Linz",
    "limit": 1,
    "name": null,
    "genre":  [{
         "name": null,
          "limit": 1
    }]
  }
    HERE_DOC
    query = Query.new(query_hash: non_array_hash,
                      location_property: 'origin',
                      answer_property: '$.genre[*].name')
    assert_not query.save!, "could unexpectedly save query with non-array query_hash"
  end

  test "should get query" do
    query    = @query.get 'Salzburg'
    assert_equal Hash, query.class
  end

  test "should raise query not found" do
    assert_raise Exceptions::QueryNotFound do
      query = {
        type: '/music/artist',
        name: 'dskfjlsakdsjflajdlkföjsflsfjl314', # i hope that this is not a valid band name =)
        album: []
      }
      @query.send :fire_query, query
    end
  end

  test "should get the police" do
    query = {
      type: '/music/artist',
      name: 'The Police',
      album: []
    }
    result = @query.send :fire_query, query

    assert_not_nil result
    assert_nil result['error']
  end

  test "should get people from linz" do
    query = {
      "type" => "/people/person",
      "place_of_birth~=" => "Linz",
      "limit" => 1,
      "name" => nil,
      "profession" => [{
        "name" => []
      }]
    }
    result =  @query.send :fire_query, query
    assert_not_nil result
    assert_nil result['error']
  end

  test "should get people from vienna" do
    query = {
      "type" => "/people/person",
      "place_of_birth~=" => "vienna",
      "limit" => 1,
      "name" => nil,
      "profession" => [{
        "name" => []
      }]
    }
    result =  @query.send :fire_query, query
    assert_not_nil result
    assert_nil result['error']
  end
end
