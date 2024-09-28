source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.3.5"

# Use Rails 7.0.8
gem "rails", "~> 7.0.8", ">= 7.0.8.4"

# The original asset pipeline for Rails
gem "sprockets-rails"

# Use sqlite3 as the database for Active Record
gem "sqlite3", "~> 1.4"

# Use the Puma web server
gem "puma", "~> 5.0"

# Use JavaScript with ESM import maps
gem "importmap-rails"

# Hotwire's SPA-like page accelerator
gem "turbo-rails"

# Hotwire's modest JavaScript framework
gem "stimulus-rails"

# Build JSON APIs with ease
gem "jbuilder"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Devise for authentication
gem "devise"

# Use ActiveAdmin for admin interface
gem "activeadmin"

# Use Sass to process CSS
gem "sassc-rails"

# Use JWT for authentication
gem "jwt"

# Use Active Model has_secure_password
gem "bcrypt", "~> 3.1.7"

group :development, :test do
  # Debugging with the debug gem
  gem "debug", platforms: %i[mri mingw x64_mingw]
end

group :development do
  # Use console on exceptions pages
  gem "web-console"

  # Speed up commands on slow machines / big apps
  # gem "spring"
end

group :test do
  # Use system testing
  gem "capybara"
  gem "selenium-webdriver"
  gem 'ransack'

# Gemfile
gem 'byebug'
end
