source 'https://rubygems.org'
ruby '2.1.1'

# backend related gems
gem 'rails', '4.0.1'
gem 'pg'

gem 'figaro' # environment variables
gem 'devise' # authentications
gem 'jbuilder', '~> 1.2'    # build json output
gem 'jsonpath', '~> 0.5.6',  :git => 'https://github.com/secretBears/jsonpath' # xpath for json



# api related gems
gem 'geokit'  # geolocations from different sources
gem 'freebase-api', :git => 'https://github.com/secretBears/freebase-api' # freebase api
# gem 'freebase-api', group: [:development, :production] # original freebase api # original freebase gem

# frontend related gems
gem 'jquery-rails'           # jquery for rails
gem 'sass-rails', '~> 4.0.0' # sass for rails
gem 'haml-rails'             # haml layout
gem 'foundation-rails'       # foundation for backend styling
gem 'uglifier', '>= 1.3.0'   # uglifiing js and css


gem 'lorem_ipsum_amet', '~> 0.6.2' # dummy text generator

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

gem 'rubocop'

group :development, :test do
  gem 'debugger'
  gem 'heroku'
  gem 'travis'
  gem 'rest-client', '~> 1.6.7'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
end

group :production do
  gem 'rails_12factor'
end

# TODO: check if these gems are needed
gem 'turbolinks'
gem 'therubyracer'
gem 'simple_form'
gem 'multi_json'










