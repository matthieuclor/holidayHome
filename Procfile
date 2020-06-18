web: bin/rails s -p ${PORT:-5000} -e $RAILS_ENV
worker: bundle exec sidekiq --environment $RAILS_ENV -C config/sidekiq.yml
