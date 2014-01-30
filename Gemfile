source 'https://rubygems.org'

ruby '2.0.0'
gem 'rails', '3.2.14'


group :test do
  gem 'rspec-rails'
  gem 'konacha'
  gem 'factory_girl_rails'
  gem 'capybara'
end

group :development, :test do
 gem 'foreman'
 gem 'dotenv-rails'
end

group :development, :production do
  gem 'bcrypt-ruby', ' ~> 3.0.0'
  gem 'pg'
  gem "haml"
  gem 'typhoeus'
  gem 'soundcloud'
  gem 'gon', '3.0.5'
  gem 'will_paginate'
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'ejs'
  gem 'foundation-rails'
  gem 'foundation-icons-sass-rails'
end

group :development do
  gem 'quiet_assets'
  gem 'pry-rails'
end

group :production do
  gem 'rails_12factor'
end

gem 'jquery-rails'
