['all', Rails.env].each do |seed|
  seed_file = "#{Rails.root}/db/seeds/#{seed}.rb"
  if File.exist?(seed_file)
    puts "*** Loading #{seed} seed data"
    require seed_file
  end
end
