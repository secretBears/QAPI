# all helpers and functionality which is not
# directly class related can be found here

class Utilities
  def self.string_to_json_path(path, json)
    JsonPath.new(path).on(json)
  end
end
