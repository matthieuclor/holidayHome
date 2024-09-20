# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.1.0'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.5.0'
# Use Puma as the app server
gem 'puma', '~> 6.4.3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 6.0.0'
# Shakapacker makes it easy to use the JavaScript pre-processor and bundler Webpack v5+ to manage frontend JavaScript in Rails
gem 'shakapacker', '~> 7.2.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5.2.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.11.0'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 5.2.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
gem 'image_processing', '~> 1.12.0'
# The official AWS SDK for Ruby
gem 'aws-sdk-s3', '~> 1.147.0', require: false
# Active Storage Validations
gem 'active_storage_validations', '~> 1.1.0'

# Background jobs
gem 'sidekiq', '~> 7.2.4'
# Devise is a flexible authentication solution for Rails based on Warden.
gem 'devise', '~> 4.9.0'
# A ruby implementation of the RFC 7519 OAuth JSON Web Token (JWT) standard.
gem 'jwt', '~> 2.8.0'
# Simple Form aims to be as flexible as possible while helping you with powerful components to create your forms.
gem 'simple_form', '~> 5.3.0'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '~> 1.18.0', require: false
# Ransack enables the creation of both simple and advanced search forms for your Ruby on Rails application
gem 'ransack', '~> 4.1.0'
# Pagy is the ultimate pagination gem that outperforms the others in each and every benchmark and comparison.
gem 'pagy', '~> 8.2.0'
# Interactors (business objects)
gem 'interactor', '~> 3.1.0'
# Beautiful JavaScript charts with one line of Ruby
gem 'chartkick', '~> 5.0.0'
# Sentry is a realtime event logging and aggregation platform.
gem 'sentry-ruby', '~> 5.17.0'
# SitemapGenerator is the easiest way to generate Sitemaps in Ruby
gem 'sitemap_generator', '~> 6.3.0'
# Faraday is an HTTP client library that provides a common interface over many adapters
gem 'faraday', '~> 2.9.0'
# A simple wrapper to send notifications to Slack webhooks.
gem 'slack-notifier', '~> 2.4.0'

group :staging do
  gem 'rest-client', '~> 2.1.0'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', '~> 11.1.0', platforms: %i(mri mingw x64_mingw)
end

group :development do
  gem 'listen', '~> 3.9.0'
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '~> 4.2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '~> 4.2.0'
  gem 'spring-watcher-listen', '~> 2.1.0'
  # Preview email in the default browser instead of sending it.
  gem 'letter_opener', '~> 1.10.0'
  # A Rake task that helps you find dead routes and unused actions
  gem 'traceroute', '~> 0.8.0'
  # A RuboCop extension focused on enforcing Rails best practices and coding conventions.
  gem 'rubocop-rails', '~> 2.24.0'
  # Capybara-specific analysis for your projects, as an extension to RuboCop.
  gem 'rubocop-capybara', '~> 2.20.0'
  # gem factory_bot-specific analysis for your projects, as an extension to RuboCop.
  gem 'rubocop-factory_bot', '~> 2.25.0'
  # Squasher compresses old ActiveRecord migrations
  gem 'squasher', '~> 0.8.0'
  # Manage Procfile-based applications
  gem 'foreman', '~> 0.88.0'
end

group :test do
  # The Bullet gem is designed to increase your application's performance by reducing the number of queries.
  gem 'bullet', '~> 7.1.0'
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 3.40.0'
  gem 'selenium-webdriver', '~> 4.19.0'

  # Easy installation and use of web drivers to run system tests with browsers
  # gem 'webdrivers', '~> 5.3.0'

  # factory_bot is a fixtures replacement with a straightforward definition syntax
  gem 'factory_bot_rails', '~> 6.4.0'
  # This gem is a port of Perl's Data::Faker library that generates fake data.
  gem 'faker', '~> 3.3.0'
end
