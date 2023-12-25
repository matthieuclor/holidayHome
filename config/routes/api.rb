namespace :api, defaults: { format: :json } do
  scope module: :authentification do
    resources :sessions, only: :create
  end

  resource :bookings, only: [] do
    scope module: :bookings do
      resources :range, only: :index
    end
  end

  resource :current_families, only: :update
  resource :current_venues, only: :update
  resources :families, only: :index
  resources :venues, only: :index
end