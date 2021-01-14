# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.2'
# Use Puma as the app server
gem 'puma', '~> 5.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5.2'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.1'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.2'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
gem 'image_processing', '~> 1.2'
# The official AWS SDK for Ruby
gem 'aws-sdk-s3', require: false
# Active Storage Validations
gem 'active_storage_validations'

# Background jobs
gem 'sidekiq', '~> 6.1'
# Devise is a flexible authentication solution for Rails based on Warden.
gem 'devise'
# Simple Form aims to be as flexible as possible while helping you with powerful components to create your forms.
gem 'simple_form'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '~> 1.5', require: false
# Ransack enables the creation of both simple and advanced search forms for your Ruby on Rails application
gem 'ransack'
# Pagy is the ultimate pagination gem that outperforms the others in each and every benchmark and comparison.
gem 'pagy'
# Interactors (business objects)
gem 'interactor'
# Beautiful JavaScript charts with one line of Ruby
gem 'chartkick'
# Sentry is a realtime event logging and aggregation platform.
gem 'sentry-raven'
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
  gem 'listen', '~> 3.4'
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0'
  # Preview email in the default browser instead of sending it.
  gem 'letter_opener', '~> 1.7'
  # A Rake task that helps you find dead routes and unused actions
  gem 'traceroute'
  # A RuboCop extension focused on enforcing Rails best practices and coding conventions.
  gem 'rubocop-rails'
end

group :test do
  # The Bullet gem is designed to increase your application's performance by reducing the number of queries.
  gem 'bullet'
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.3'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
  # factory_bot is a fixtures replacement with a straightforward definition syntax
  gem 'factory_bot_rails'
  # This gem is a port of Perl's Data::Faker library that generates fake data.
  gem 'faker'
end
