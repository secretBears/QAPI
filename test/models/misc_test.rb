require 'test_helper'

class MiscTest < ActiveSupport::TestCase
  test "should get json path" do
    element = <<-HERE_DOC
      {
        "hallo": "Alex"
      }
    HERE_DOC

    path = '$.hallo'
    replace = 'Stefan'

    replacement = Misc.replace_in_json element, path, replace
    assert_equal replacement['hallo'], replace
  end
end
