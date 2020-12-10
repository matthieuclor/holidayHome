# frozen_string_literal: true

module UserAccount
  module Authentification
    class RegistrationsController < Devise::RegistrationsController
      # include SkipBullet

      before_action :configure_sign_up_params, only: :create
      before_action :configure_account_update_params, only: :update
      # around_action :skip_bullet, only: :destroy

      def new # rubocop:disable Lint/UselessMethodDefinition
        super
      end

      def create # rubocop:disable Lint/UselessMethodDefinition
        super
      end

      def edit # rubocop:disable Lint/UselessMethodDefinition
        super
      end

      def update # rubocop:disable Lint/UselessMethodDefinition
        super
      end

      def destroy # rubocop:disable Lint/UselessMethodDefinition
        super
      end

      protected

      def configure_sign_up_params
        devise_parameter_sanitizer.permit(
          :sign_up,
          keys: %i(first_name last_name)
        )
      end

      def configure_account_update_params
        devise_parameter_sanitizer.permit(
          :account_update,
          keys: %i(first_name last_name avatar phone address)
        )
      end

      def after_sign_up_path_for(resource)
        session[:hutoki_plan] == 'premium' &&
          resource.update(plan: :premium, plan_deadline: Date.current + 1.year)

        user_account_dashboards_path
      end

      def after_update_path_for(_resource)
        user_account_settings_path
      end

      def after_inactive_sign_up_path_for(_resource)
        user_account_dashboards_path
      end
    end
  end
end
