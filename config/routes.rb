Rails.application.routes.draw do
  root to: 'public#index'

  devise_for :users, controllers: {
    confirmations: 'authentication/user/confirmations',
    passwords: 'authentication/user/passwords',
    registrations: 'user_account/authentification/registrations',
    sessions: 'user_account/authentification/sessions',
    unlocks: 'authentication/user/unlocks'
  }
end
