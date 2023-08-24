# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'audited', '~> 4.10', '>= 4.10.0'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'bootstrap', '>= 4.5.2'
gem 'bootstrap-datepicker-rails', '>= 1.10.0.1'
gem 'coffee-rails', '~> 5.0'
gem 'devise', '>= 4.7.2'
gem 'dotenv-rails', '>= 2.8.0'
gem 'jquery-rails', '>= 4.5.0'
gem 'kaminari', '>= 1.2.2'
gem 'mysql2', '>= 0.3.18', '< 0.6'
gem 'puma', '~> 5.6'
gem 'rails', '~> 6.1', '>= 6.1.7.5'
gem 'rinku'
gem 'rollbar'
gem 'sassc-rails'
gem 'slim-rails', '>= 3.3.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'validates_timeliness', '~> 5.0.0.beta2'

# NOTE: When we'll try to build this Docker image for production,
# we'll have this issue when try to install mini_racer with v8 on Alpine Linux:
# LoadError: Error relocating /usr/local/bundle/gems/mini_racer-0.2.6/lib/mini_racer_extension.so:
# backtrace_symbols: symbol not found - /usr/local/bundle/gems/mini_racer-0.2.6/lib/mini_racer_extension.so
#
# To fix this we need to use ruby-slim image instead of alpine :-(
# Alexander Kadyrov, 2019-11-05
group :production do
  gem 'mini_racer'
end

group :development, :test do
  gem 'brakeman', require: false
  gem 'bundle-audit', require: false
  gem 'rspec-rails', '~> 4.0', '>= 4.0.2'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', '>= 2.8.1', require: false
  gem 'rubocop-rspec', require: false
end

group :development do
  gem 'annotate', '>= 3.2.0'
  gem 'better_errors'
  gem 'letter_opener'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', require: 'capybara/rspec'
  gem 'database_cleaner-active_record', '>= 2.1.0'
  gem 'factory_bot_rails', '>= 5.2.0'
  gem 'ffaker'
  gem 'selenium-webdriver'
  gem 'shoulda-callback-matchers', '~> 1.1.1'
  gem 'shoulda-matchers', '~> 4.0', '>= 4.0.1'
  # Workaround for cc-test-reporter with SimpleCov 0.18.
  # Stop upgrading SimpleCov until the following issue will be resolved.
  # https://github.com/codeclimate/test-reporter/issues/418
  gem 'simplecov', '~> 0.19', require: false
end
