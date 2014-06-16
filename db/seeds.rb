['all', Rails.env].each do |seed|
  seed_file = "#{Rails.root}/db/seeds/#{seed}.rb"
  next unless File.exist?(seed_file)

  Rails.logger.info "*** Loading #{seed} seed data"
  require seed_file
end
