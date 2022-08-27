# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

Dotenv::Railtie.load

module RealEstateAgency
  class Application < Rails::Application
    config.load_defaults 6.0
    config.autoloader = :zeitwerk

    # Don't generate system test files.
    config.generators.system_tests = nil

    config.i18n.load_path += Dir[Rails.root.join('config/locales/controllers/*/*.yml').to_s]
    config.i18n.load_path += Dir[Rails.root.join('config/locales/models/*/*.yml').to_s]
    config.i18n.load_path += Dir[Rails.root.join('config/locales/views/*/*.yml').to_s]
    config.i18n.default_locale = :ru

    config.time_zone = 'Moscow'

    # NOTE: https://github.com/collectiveidea/audited/issues/631
    # List of classes deemed safe to load by YAML, and required by the Audited
    # gem when deserialized audit records.
    # As of Rails 6.0.5.1, YAML safe-loading method does not allow all classes
    # to be deserialized by default: https://discuss.rubyonrails.org/t/cve-2022-32224-possible-rce-escalation-bug-with-serialized-columns-in-active-record/81017
    config.active_record.yaml_column_permitted_classes = [
      ActiveSupport::HashWithIndifferentAccess,
      ActiveSupport::TimeWithZone,
      ActiveSupport::TimeZone,
      Date,
      Time
    ]
  end
end
