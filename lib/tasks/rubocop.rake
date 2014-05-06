require 'rubocop/rake_task'

Rubocop::RakeTask.new(:rubocop) do |task|
  task.patterns = %w'lib/**/*.rb app/**/*.rb test/**/*.rb'
end

task :default => [:rubocop]