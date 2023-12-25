namespace :user_account do
  scope module: 'authentification/registrations' do
    resource :plans, only: :create
    resource :avatars, only: :destroy
    resource :statuses, only: :destroy
  end

  resources :dashboards, only: :index
  resources :notifications, only: %i(index show)
  resources :settings, only: :index
  resource :current_families, only: :update
  resource :current_venues, only: :update
  resource :current_school_holiday_zones, only: :update
  resources :families, only: %i(index new create edit update destroy)
  resources :family_links, only: :destroy
  resources :users, only: %i(index show)
  resources :received_invitations, only: %i(index update)
  resource :plans, only: %i(show edit update)
  resource :algolia_places, only: :create
  resources :vehicle_types, only: :index

  resources :venues do
    scope module: :venues do
      resources :photos, only: %i(create destroy)
      resources :vehicles, only: %i(index new create edit update destroy)
    end
  end

  resources :bookings, only: %i(index show create) do
    resources :messages, only: %i(index create)
    resources :booking_approvals, only: :update

    collection do
      scope module: :bookings do
        resources :status, only: :update
        resources :range, only: :index
        resources :pending, only: :index
      end
    end
  end

  resource :school_holidays, only: %i() do
    scope module: :school_holidays do
      resources :range, only: :index
    end
  end

  resources :sended_invitations, only: %i(index new create destroy) do
    resource :resends, module: :sended_invitations, only: :update
  end
end