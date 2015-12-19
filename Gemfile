source 'https://rubygems.org'

ruby '2.2.3'

gem 'rails', '4.2.5'

gem 'unicorn'

gem 'rails-api'
gem 'roar-rails', '~> 1.0.1'
gem 'representable', '~> 2.2.3'
gem 'roar', '= 1.0.1'
gem 'virtus'
gem 'interactor-rails', '~> 2.0'

# request nokogiri above 1.6.7.1 because of security advisories
gem 'nokogiri', '>= 1.6.7.1'

gem 'doorkeeper'

# tags!
gem 'acts-as-taggable-on'

# search!
gem 'ransack'

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
