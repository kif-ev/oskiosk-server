source 'https://rubygems.org'

gem 'rails', '4.2.0'

gem 'unicorn'

gem 'rails-api'
# Needed until (released) roar-rails requires it itself
# see https://github.com/apotonick/roar-rails/issues/87
gem 'responders', '~> 2.0.0'
gem 'roar-rails', '~> 1.0.0'
gem 'interactor-rails', '~> 2.0'

gem 'doorkeeper'

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
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem "codeclimate-test-reporter", require: false
end

gem 'pg'

gem 'rails_12factor', group: :production
