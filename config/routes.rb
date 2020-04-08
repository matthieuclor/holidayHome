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
    resource :current_families, only: [:update]
    resources :families
    resources :invitations, only: [:index, :new, :create, :destroy] do
      scope module: :invitations do
        resource :mails, only: [:update]
        resource :approves, only: [:new]
        resource :disapproves, only: [:new]
        resource :registrations, only: [:new, :create]
      end
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
