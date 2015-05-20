source 'https://rubygems.org'

ruby '2.2.2'

gem 'rails', '4.2.1'

gem 'unicorn'

gem 'rails-api'
gem 'roar-rails', '~> 1.0.1'
gem 'virtus'
gem 'interactor-rails', '~> 2.0'

gem 'doorkeeper'

# tags!
gem 'acts-as-taggable-on'

# search and stats!
gem 'ransack'
gem 'active_record_union'

gem 'swagger-docs'

gem 'rack-cors'

gem 'skylight'

gem 'bugsnag'

group :development do
  gem 'growl'
  gem 'guard'
  gem 'guard-bundler'
  gem 'guard-rspec'
  gem 'guard-cucumber'
end

group :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails', '~> 3.0'
  gem 'rspec-its'
  gem 'cucumber-rails', require: false, git: 'https://github.com/cucumber/cucumber-rails.git'
  gem 'database_cleaner'
  gem "codeclimate-test-reporter", require: false
end

gem 'pg'

gem 'rails_12factor', group: :production
