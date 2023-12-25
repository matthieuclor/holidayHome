authenticate :admin do
  mount Sidekiq::Web => '/sidekiq'
end