# all helpers and functionality which is not
# directly class related can be found here

class Misc
  def self.find_in_json(element, path)
    JsonPath.on(element, path)
  end

  def self.replace_in_json(element, path, replace)
    JsonPath.for(element).gsub(path) { |v| replace }.to_hash
  end
end
