Raven.configure do |config|
  config.dsn = ENV['SENTRY_DSN']
  config.environments  = %w(production)
  config.async = lambda { |event| SentryJob.perform_later(event) }
end
