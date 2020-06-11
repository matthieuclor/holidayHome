require "sidekiq/web"

Rails.application.routes.draw do
  scope module: :public do
    root to: 'pages#main'

    scope module: :invitations do
      resource :responses, only: [:new]
      resource :registrations, as: :invitation_registrations, only: [:new, :create]
    end
  end

  devise_for :users, controllers: {
    sessions: 'user_account/authentification/sessions',
    registrations: 'user_account/authentification/registrations',
    passwords: 'user_account/authentification/passwords',
    confirmations: 'user_account/authentification/confirmations',
    unlocks: 'user_account/authentification/unlocks'
  }

  namespace :user_account do
    scope module: 'authentification/registrations' do
      resource :avatars, only: [:destroy]
    end

    resources :dashboards, only: [:index]
    resources :settings, only: [:index]
    resource :current_families, only: [:update]
    resource :current_venues, only: [:update]
    resources :families, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :venues
    resources :users, only: [:index, :show]
    resources :received_invitations, only: [:index, :update]

    resources :bookings, only: [:index, :show, :create, :update] do
      resources :messages, only: [:index, :create]
      resources :booking_approvals, only: [:edit, :update]

      collection do
        scope module: :bookings do
          resources :yearly, only: [:index]
          resources :monthly, only: [:index]
          resources :pending, only: [:index]
        end
      end
    end

    resources :sended_invitations, only: [:index, :new, :create, :destroy] do
      resource :resends, module: :sended_invitations, only: [:update]
    end
  end

  devise_for :admins, controllers: {
    sessions: 'admin_account/authentification/sessions'
  }

  namespace :admin_account do
    resources :dashboards, only: [:index]

    resources :users do
      scope module: :users do
        resource :email_confirmation, only: [:update]
      end
    end

    resources :families
    resources :invitations
    resources :venues
  end

  authenticate :admin do
    mount Sidekiq::Web => '/sidekiq'
  end
end
