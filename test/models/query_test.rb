require 'test_helper'

class QAPIGeneratorTest < ActiveSupport::TestCase
  setup do
    @query_hash = {
        "type" => "/people/person",
        "place_of_birth~=" => "Linz",
        "limit" => 1,
        "name" => nil,
        "profession" => [{
                             "name" => []
                         }]
    }

    @location_property = "place_of_birth~="
    @answer_property   = "profession"

    @query = Query.new(
        query_hash: @query_hash,
        location_property: @location_property,
        answer_property: @answer_property
    )
  end

  test "should rise argument error" do
    assert_raise ArgumentError do
      Query.new test: 'lalelu'
    end
  end

  test "should create query" do
    assert_equal Query, @query.class
  end

  test "should get query" do
    query    = @query.get 'Salzburg'
    assert_equal 'Salzburg', query[@query.location_property]
    assert_equal Hash, query.class

    query    = @query.get 'Wien'
    assert_equal 'Wien', query[@query.location_property]
    assert_equal Hash, query.class
  end

end
