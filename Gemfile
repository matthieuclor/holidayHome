# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.1.2'
# Use postgresql as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma'
# Use SCSS for stylesheets
gem 'sass-rails'
# Shakapacker makes it easy to use the JavaScript pre-processor and bundler Webpack v5+ to manage frontend JavaScript in Rails
gem 'shakapacker'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'
# Use Redis adapter to run Action Cable in production
gem 'redis'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
gem 'image_processing'
# The official AWS SDK for Ruby
gem 'aws-sdk-s3', require: false
# Active Storage Validations
gem 'active_storage_validations'

# Background jobs
gem 'sidekiq'
# Devise is a flexible authentication solution for Rails based on Warden.
gem 'devise'
# A ruby implementation of the RFC 7519 OAuth JSON Web Token (JWT) standard.
gem 'jwt'
# Simple Form aims to be as flexible as possible while helping you with powerful components to create your forms.
gem 'simple_form'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false
# Ransack enables the creation of both simple and advanced search forms for your Ruby on Rails application
gem 'ransack'
# Pagy is the ultimate pagination gem that outperforms the others in each and every benchmark and comparison.
gem 'pagy'
# Interactors (business objects)
gem 'interactor'
# Beautiful JavaScript charts with one line of Ruby
gem 'chartkick'
# Sentry is a realtime event logging and aggregation platform.
gem 'sentry-ruby'
# SitemapGenerator is the easiest way to generate Sitemaps in Ruby
gem 'sitemap_generator'
# Faraday is an HTTP client library that provides a common interface over many adapters
gem 'faraday'
# A simple wrapper to send notifications to Slack webhooks.
gem 'slack-notifier'

group :staging do
  gem 'rest-client'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i(mri mingw x64_mingw)
end

group :development do
  gem 'listen'
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen'
  # Preview email in the default browser instead of sending it.
  gem 'letter_opener'
  # A Rake task that helps you find dead routes and unused actions
  gem 'traceroute'
  # A RuboCop extension focused on enforcing Rails best practices and coding conventions.
  gem 'rubocop-rails'
  # Squasher compresses old ActiveRecord migrations
  gem 'squasher'
  # Manage Procfile-based applications
  gem 'foreman'
end

group :test do
  # The Bullet gem is designed to increase your application's performance by reducing the number of queries.
  gem 'bullet'
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
  # factory_bot is a fixtures replacement with a straightforward definition syntax
  gem 'factory_bot_rails'
  # This gem is a port of Perl's Data::Faker library that generates fake data.
  gem 'faker'
end
