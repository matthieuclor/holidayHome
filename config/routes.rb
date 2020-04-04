require "sidekiq/web"

Rails.application.routes.draw do
  root to: 'public#index'

  devise_for :users, controllers: {
    sessions: 'user_account/authentification/sessions',
    registrations: 'user_account/authentification/registrations',
    passwords: 'user_account/authentification/passwords',
    confirmations: 'user_account/authentification/confirmations',
    unlocks: 'user_account/authentification/unlocks'
  }

  namespace :user_account do
    resources :dashboards, only: [:index]
    resources :settings, only: [:index]
    resource :current_family_cookies, only: [:update]
    resources :families do
      resources :venues
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
    resources :families do
      resources :venues
    end
  end

  authenticate :admin do
    mount Sidekiq::Web => '/sidekiq'
  end
end
