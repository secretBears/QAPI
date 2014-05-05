require 'rubocop/rake_task'
Rubocop::RakeTask.new(:rubocop) do |task|
  task.patterns = %w'lib/**/*.rb app/**/*.rb test/**/*.rb'
  task.fail_on_error = true
end
task :default => [:rubocop]