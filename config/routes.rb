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
  end
end
