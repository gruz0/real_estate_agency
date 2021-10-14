# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'audited', '~> 4.9'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'bootstrap', '>= 4.3.1'
gem 'bootstrap-datepicker-rails'
gem 'coffee-rails', '~> 5.0'
gem 'devise'
gem 'dotenv-rails'
gem 'jquery-rails'
gem 'kaminari'
gem 'mysql2', '>= 0.3.18', '< 0.6'
gem 'puma', '~> 4.3', '>= 4.3.9'
gem 'rails', '~> 5.2.4'
gem 'rinku'
gem 'rollbar'
gem 'sassc-rails'
gem 'slim-rails'
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
  gem 'rspec-rails', '~> 4.0'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
end

group :development do
  gem 'annotate'
  gem 'better_errors'
  gem 'letter_opener'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', require: 'capybara/rspec'
  gem 'database_cleaner-active_record'
  gem 'factory_bot_rails'
  gem 'ffaker'
  gem 'selenium-webdriver'
  gem 'shoulda-callback-matchers', '~> 1.1.1'
  gem 'shoulda-matchers', '~> 3.1'
  # Workaround for cc-test-reporter with SimpleCov 0.18.
  # Stop upgrading SimpleCov until the following issue will be resolved.
  # https://github.com/codeclimate/test-reporter/issues/418
  gem 'simplecov', '~> 0.19', require: false
end
