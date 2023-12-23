require_relative "boot"

ENV['RANSACK_FORM_BUILDER'] = '::SimpleForm::FormBuilder'

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module HolidayHome
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = 'Europe/Paris'
    config.i18n.default_locale = :fr

    # config.eager_load_paths << Rails.root.join("extras")

    config.generators.system_tests = nil
    config.generators.assets = false
    config.generators.helper = false
  end
end
