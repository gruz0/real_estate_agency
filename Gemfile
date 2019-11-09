source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'audited', '~> 4.9'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'bootstrap', '>= 4.3.1'
gem 'bootstrap-datepicker-rails'
gem 'coffee-rails', '~> 4.2'
gem 'devise'
gem 'dotenv-rails'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'kaminari'
gem 'mini_racer', platforms: :ruby
gem 'mysql2', '>= 0.3.18', '< 0.5'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.2.3'
gem 'rinku'
gem 'rollbar'
gem 'sass-rails', '~> 5.0'
gem 'slim-rails'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'validates_timeliness', '~> 5.0.0.alpha3'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'ffaker'
end

group :development do
  gem 'annotate'
  gem 'better_errors'
  gem 'letter_opener'
  gem 'rails-erd'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'brakeman', '>= 4.7.1', require: false
  gem 'bundle-audit', require: false
  gem 'capybara'
  gem 'rails_best_practices', require: false
  gem 'rspec-rails', '~> 3.9'
  gem 'rubocop', require: false
  gem 'rubocop-performance'
  gem 'rubocop-rspec'
  gem 'selenium-webdriver'
  gem 'shoulda-callback-matchers', '~> 1.1.1'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'simplecov', require: false
end
