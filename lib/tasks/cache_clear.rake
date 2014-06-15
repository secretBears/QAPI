namespace :cache do
  namespace :clear do
    desc 'Cleares the Caches of the DB'

    task :all => :environment do
      Cache.clear_all
      puts 'Cleared all Caches'
    end

    task :places => :environment do
      Cache.clear_all_places
      puts 'Cleared all places'
    end

    task :questions => :environment do
      Cache.clear_all_places
    end

    task :old => :environment do
      Cache.clear_old_questions
    end
  end
end