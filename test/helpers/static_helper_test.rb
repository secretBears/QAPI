require 'test_helper'

class StaticHelperTest < ActionView::TestCase
  def self.generate_query
    location_property = "place_of_birth~="
    answer_property   = "$.profession[0].name"

    query = Query.new(
        query_hash: StaticHelperTest.query,
        location_property: location_property,
        answer_property: answer_property
    )
    query
  end

  def self.query
    {
      "type" => "/people/person",
      "place_of_birth~=" => "Linz",
      "limit" => 1,
      "name" => nil,
      "profession" => [{
        "name" => []
      }]
    }
  end
end
