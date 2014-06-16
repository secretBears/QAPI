require 'test_helper'

class QAPIGeneratorTest < ActiveSupport::TestCase
  setup do
    @query = Query.first
  end

  test "should rise argument error" do
    assert_raise ActiveRecord::UnknownAttributeError do
      Query.new test: 'lalelu'
    end
  end

  test "should get query" do
    query    = @query.get 'Salzburg'
    assert_equal Array, query.class
  end
end
