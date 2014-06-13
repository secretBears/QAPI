namespace :db do
  namespace :test do

    require_relative '../../test/helpers/fakeweb_helper'

    task :prepare => :environment do
      Rake::Task["db:seed"].invoke
    end
  end
end