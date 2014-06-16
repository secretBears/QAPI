require 'test_helper'

class QAPIGeneratorTest < ActiveSupport::TestCase
  setup do
    @query = Query.first
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
    assert_not query.save, "could unexpectedly save query with non-array query_hash"
  end

  test "should get query" do
    query    = @query.get 'Salzburg'
    assert_equal Array, query.class
  end
end
