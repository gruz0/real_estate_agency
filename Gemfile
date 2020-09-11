# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'audited', '~> 4.9'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'bootstrap', '>= 4.5.0'
gem 'bootstrap-datepicker-rails', '>= 1.9.0.1'
gem 'coffee-rails', '~> 5.0', '>= 5.0.0'
gem 'devise', '>= 4.7.1'
gem 'dotenv-rails', '>= 2.7.5'
gem 'jquery-rails', '>= 4.4.0'
gem 'kaminari', '>= 1.2.1'
gem 'mysql2', '>= 0.3.18', '< 0.6'
gem 'puma', '~> 4.3'
gem 'rails', '~> 5.2.4', '>= 5.2.4.4'
gem 'rinku'
gem 'rollbar'
gem 'sassc-rails', '>= 2.1.2'
gem 'slim-rails', '>= 3.2.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'validates_timeliness', '~> 5.0.0.beta1'

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
  gem 'database_cleaner'
  gem 'factory_bot_rails', '>= 5.1.1'
  gem 'ffaker'
end

group :development do
  gem 'annotate'
  gem 'better_errors'
  gem 'letter_opener'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', require: false
  gem 'rspec-rails', '~> 4.0', '>= 4.0.1'
  gem 'selenium-webdriver', require: false
  gem 'shoulda-callback-matchers', '~> 1.1.1'
  gem 'shoulda-matchers', '~> 3.1'
  # Workaround for cc-test-reporter with SimpleCov 0.18.
  # Stop upgrading SimpleCov until the following issue will be resolved.
  # https://github.com/codeclimate/test-reporter/issues/418
  gem 'simplecov', '~> 0.10', '< 0.18', require: false
end
