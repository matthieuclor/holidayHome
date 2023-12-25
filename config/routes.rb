require "sidekiq/web"

Rails.application.routes.draw do
  draw(:public)

  draw(:devise_for_user)

  draw(:user_account)

  draw(:api)

  draw(:devise_for_admin)

  draw(:admin_account)

  draw(:sidekiq)
end
