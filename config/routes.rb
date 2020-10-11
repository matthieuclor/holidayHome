require "sidekiq/web"

Rails.application.routes.draw do
  scope module: :public do
    root 'pages#main'

    scope module: :pages do
      get 'about'
      get 'pricing'
      get 'qui-sommes-nous', action: :teams, as: :teams
      get 'faq'
      get 'cgu'
      get 'politique-confidentialite', action: :privacy_policy, as: :privacy_policy
      get 'mentions-legales', action: :company_details, as: :company_details
      get 'sitemap'
    end

    resources :blog, only: [:index, :show]

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
      resource :statuses, only: [:destroy]
    end

    resources :dashboards, only: [:index]
    resources :notifications, only: [:index, :show]
    resources :settings, only: [:index]
    resource :current_families, only: [:update]
    resource :current_venues, only: [:update]
    resources :families, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :family_links, only: [:destroy]
    resources :users, only: [:index, :show]
    resources :received_invitations, only: [:index, :update]

    resources :venues do
      scope module: :venues do
        resources :photos, only: [:create, :destroy]
      end
    end

    resources :bookings, only: [:index, :show, :create] do
      resources :messages, only: [:index, :create]
      resources :booking_approvals, only: [:update]

      collection do
        scope module: :bookings do
          resources :status, only: [:update]
          resources :range, only: [:index]
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

    resources :design_system, only: [:index] do
      collection do
        scope module: :design_system do
          resources :toasts, only: [:create]
          resources :modals, only: [:create]
        end
      end
    end

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
