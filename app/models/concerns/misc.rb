# all helpers and functionality which is not
# directly class related can be found here

class Misc
  # def self.string_to_json_path(path, json)
  #   JsonPath.new(path).on(json)
  # end

  def self.replace_in_json(element, path, replace)
    JsonPath.for(element).gsub(path) { |v| replace }.to_hash
  end

  def self.decode_params(params)
    params.merge(params) do|k,param|
      URI.unescape(param)
    end
  end
end
