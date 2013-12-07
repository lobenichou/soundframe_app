source 'https://rubygems.org'

ruby '2.0.0'
gem 'rails', '3.2.14'


group :test do
  gem 'rspec-rails'
  gem 'konacha'
end

group :development, :test do
 gem 'foreman'
end

group :development, :production do
  gem 'bcrypt-ruby', ' ~> 3.0.0'
  gem 'pg'
  gem 'jquery-rails'
  gem 'typhoeus'
  gem 'soundcloud'
  gem 'bootstrap-sass-rails'
  gem 'gon', '3.0.5'
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem 'quiet_assets'
  gem 'pry-rails'
end

group :production do
  gem 'rails_12factor'
end

