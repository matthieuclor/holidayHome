namespace :admin_account do
  resources :dashboards, only: :index

  resources :design_system, only: :index do
    collection do
      scope module: :design_system do
        resources :toasts, only: :create
        resources :modals, only: :create
      end
    end
  end

  resources :users, only: %i(index show edit update) do
    scope module: :users do
      resource :email_confirmations, only: :update
      resources :sessions, only: :create
      resources :families, only: :index
      resources :received_invitations, only: :index
      resources :sended_invitations, only: :index
    end
  end

  resources :families, only: %i(index show edit update) do
    scope module: :families do
      resources :users, only: :index
      resources :venues, only: :index
      resources :bookings, only: :index
    end
  end

  resources :articles do
    scope module: :articles do
      resource :status, only: :update
    end
  end

  resources :question_and_answers do
    scope module: :question_and_answers do
      resource :status, only: :update
    end
  end

  resources :team_members, only: %i(index new create edit update destroy) do
    scope module: :team_members do
      resource :photos, only: :destroy
    end
  end

  resources :venues, only: %i(show edit update) do
    scope module: :venues do
      resources :photos, only: %i(create destroy)
      resources :keys, only: %i(edit update)
      resources :networks, only: %i(edit update)
      resources :digital_codes, only: %i(edit update)
      resources :home_services, only: %i(edit update)
      resources :vehicles, only: %i(edit update)
    end
  end

  resources :bookings, only: %i(show edit update) do
    scope module: :bookings do
      resources :booking_approvals, only: %i(index edit update)
      resources :messages, only: :index
    end
  end

  resources :admins, only: :index
  resources :school_holidays, only: %i(index create)
  resources :vehicle_types, only: %i(index new create edit update destroy)
end