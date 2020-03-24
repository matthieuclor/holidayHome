Rails.application.routes.draw do
  root to: 'public#index'

  devise_for :users, controllers: {
    sessions: 'user_account/authentification/sessions',
    registrations: 'user_account/authentification/registrations',
    passwords: 'user_account/authentication/user/passwords'
  }

  namespace :user_account do
    resources :dashboards, only: [:index]
    resources :settings, only: [:index]
  end
end
