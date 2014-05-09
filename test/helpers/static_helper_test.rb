require 'test_helper'

class StaticHelperTest < ActionView::TestCase
  def self.generate_query
    query = {
        "type" => "/people/person",
        "place_of_birth~=" => "Linz",
        "limit" => 1,
        "name" => nil,
        "profession" => [{
                             "name" => []
                         }]
    }

    location_property = "place_of_birth~="
    answer_property   = "profession"

    query = Query.new(
        query_hash: query,
        location_property: location_property,
        answer_property: answer_property
    )
    query
  end
end
