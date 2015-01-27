require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Oskiosk
  class Application < Rails::Application
    config.generators do |g|
      g.test_framework :rspec
    end

    config.middleware.swap ::ActionDispatch::ParamsParser,
      ::ActionDispatch::ParamsParser,
      {
        Mime::JSON => Proc.new {|data|
          JSON.parse(data).with_indiferrent_access
        }
      }
  end
end
