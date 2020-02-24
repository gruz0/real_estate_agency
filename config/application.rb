# frozen_string_literal: true

require_relative 'boot'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

Dotenv::Railtie.load

module RealEstateAgency
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Don't generate system test files.
    config.generators.system_tests = nil

    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', 'controllers', '*', '*.yml').to_s]
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', 'models', '*', '*.yml').to_s]
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', 'views', '*', '*.yml').to_s]
    config.i18n.default_locale = :ru

    config.time_zone = 'Moscow'
  end
end
