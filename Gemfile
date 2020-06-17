# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'audited', '~> 4.9'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'bootstrap', '>= 4.4.1'
gem 'bootstrap-datepicker-rails', '>= 1.9.0.1'
gem 'coffee-rails', '~> 5.0', '>= 5.0.0'
gem 'devise', '>= 4.7.1'
gem 'dotenv-rails', '>= 2.7.5'
gem 'jquery-rails', '>= 4.4.0'
gem 'kaminari'
gem 'mini_racer', platforms: :ruby
gem 'mysql2', '>= 0.3.18', '< 0.6'
gem 'puma', '~> 3.12'
gem 'rails', '~> 5.2.4', '>= 5.2.4.3'
gem 'rinku'
gem 'rollbar'
gem 'sassc-rails', '>= 2.1.2'
gem 'slim-rails', '>= 3.2.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'validates_timeliness', '~> 5.0.0.beta1'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'database_cleaner'
  gem 'factory_bot_rails', '>= 5.1.1'
  gem 'ffaker'
end

group :development do
  gem 'annotate'
  gem 'better_errors', '>= 2.6.0'
  gem 'letter_opener'
  gem 'rails-erd'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'brakeman', '>= 4.7.1', require: false
  gem 'bundle-audit', require: false
  gem 'capybara', '>= 3.32.2'
  gem 'rails_best_practices', require: false
  gem 'rspec-rails', '~> 4.0', '>= 4.0.1'
  gem 'rubocop', require: false
  gem 'rubocop-performance'
  gem 'rubocop-rspec'
  gem 'selenium-webdriver'
  gem 'shoulda-callback-matchers', '~> 1.1.1'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'simplecov', require: false
end
