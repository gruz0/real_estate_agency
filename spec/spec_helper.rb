# frozen_string_literal: true

require 'simplecov'
SimpleCov.start 'rails' do
  coverage_dir 'coverage/backend'

  add_filter 'app/mailers'
  add_filter 'app/jobs'
  add_filter 'app/views'

  add_group 'Controllers', 'app/controllers'
  add_group 'Helpers', 'app/helpers'
  add_group 'Models', 'app/models'
  add_group 'Queries', 'app/queries'
  add_group 'Libraries', 'lib'
end

require 'factory_bot'

Dir[File.dirname(__FILE__) + '/support/**/*.rb'].sort.each { |f| require f }

RSpec.configure do |config|
  config.include AppHelper

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_run_when_matching :focus
  config.example_status_persistence_file_path = 'spec/examples.txt'
  config.disable_monkey_patching!
  config.order = :random

  Kernel.srand config.seed
end
