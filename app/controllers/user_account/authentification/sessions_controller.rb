# frozen_string_literal: true

module UserAccount
  module Authentification
    class SessionsController < Devise::SessionsController
      respond_to :html, :js

      def new # rubocop:disable Lint/UselessMethodDefinition
        super
      end

      def create # rubocop:disable Lint/UselessMethodDefinition
        super
      end

      def destroy # rubocop:disable Lint/UselessMethodDefinition
        super
      end

      protected

      def after_sign_in_path_for(_resource)
        session[:previous_url] || user_account_dashboards_path
      end
    end
  end
end
