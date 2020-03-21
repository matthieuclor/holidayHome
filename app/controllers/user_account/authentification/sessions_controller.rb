# frozen_string_literal: true

class UserAccount::Authentification::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]
  respond_to :html, :js

  def new
    super
  end

  def create
    super
  end

  def destroy
    super
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || user_account_dashboards_path
  end
end
