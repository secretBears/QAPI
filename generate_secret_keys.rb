# simple script for adding environment variables to heroku and travis

require 'yaml'
require 'fileutils'
keys   = YAML.load_file('config/application.yml')
travis = YAML.load_file('.travis.yml')

travis['env']['global'] = []

File.open('.travis.yml', 'w') {|f| f.write travis.to_yaml }

puts 'generate keys, this could take a while'
keys.each do |key,value|
  system "heroku config:unset #{key}"
  system "heroku config:set #{key}=#{value}"
  system "travis encrypt #{key}=#{value} --add env.global"
end

