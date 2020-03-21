Rails.application.routes.draw do
  root to: 'public#index'

  devise_for :users, controllers: {
    confirmations: 'user_account/authentication/user/confirmations',
    passwords: 'user_account/authentication/user/passwords',
    registrations: 'user_account/authentification/registrations',
    sessions: 'user_account/authentification/sessions',
    unlocks: 'user_account/authentication/user/unlocks'
  }

  namespace :user_account do
    resources :dashboards, only: [:index]
  end
end
