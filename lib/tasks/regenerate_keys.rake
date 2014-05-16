# simple script for adding environment variables to heroku and travis

require 'yaml'
require 'fileutils'

task :regenerate_keys do
  root_dir = Rails.root

  keys   = YAML.load_file("#{root_dir}/config/application.yml")
  travis = YAML.load_file("#{root_dir}/.travis.yml")

  travis['env']['global'] = []

  File.open("#{root_dir}/.travis.yml", 'w') {|f| f.write travis.to_yaml }

  puts 'generate keys, this could take a while'
  keys.each do |key,value|
    system "(cd #{root_dir} && exec heroku config:unset #{key})"
    system "(cd #{root_dir} && heroku config:set #{key}=#{value})"
    system "(cd #{root_dir} && travis encrypt #{key}=#{value} --add env.global)"
  end
end


