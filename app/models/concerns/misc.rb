# all helpers and functionality which is not
# directly class related can be found here

class Misc
  def self.find_in_json(element, path)
    path = path.insert(0, "$..*.") if path[/^\$\.\.\*\./].nil?
    JsonPath.on(Array.wrap(element), path)
  end

  def self.replace_in_json(element, path, replace)
    path = path.insert(0, "$..*.") if path[/^\$\.\.\*\./].nil?
    JsonPath.for(element).gsub(path) { |_v| replace }.to_hash
  end

  def self.decode_params(params)
    params.merge(params) do|_k, param|
      URI.unescape(param)
    end
  end
end
