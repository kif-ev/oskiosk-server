source 'https://rubygems.org'

ruby '2.3.3'

# explicit dependencies on stdlib stuff
gem 'bigdecimal'
gem 'json'

gem 'rails', '~> 5.1.0'

gem 'unicorn'

gem 'responders'
gem 'roar-rails'
gem 'representable'
gem 'roar'
gem 'multi_json'
gem 'virtus'
gem 'interactor-rails'

gem 'doorkeeper'

# tags!
gem 'acts-as-taggable-on', git: 'https://github.com/mbleigh/acts-as-taggable-on.git'

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

gem 'rails-html-sanitizer', '~> 1.0.3'
