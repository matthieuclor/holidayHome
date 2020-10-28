# frozen_string_literal: true

class UserAccount::Authentification::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  def new
    super
  end

  def create
    super
  end

  def edit
    super
  end

  def update
    super
  end

  def destroy
    super
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :avatar, :phone, :address])
  end

  def after_sign_up_path_for(resource)
    if cookies[:hutoki_plan] == "premium"
      resource.update(plan: :premium, plan_deadline: Date.current + 1.year)
    end

    user_account_dashboards_path
  end

  def after_update_path_for(resource)
    user_account_settings_path
  end

  def after_inactive_sign_up_path_for(resource)
    user_account_dashboards_path
  end
end
