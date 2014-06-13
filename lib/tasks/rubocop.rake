require 'rubocop/rake_task'

task :rubocop do
  system "(cd #{Rails.root} && exec rubocop -a -R)"
end

task :default => [:rubocop]