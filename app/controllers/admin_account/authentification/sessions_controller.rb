# frozen_string_literal: true

module AdminAccount
  module Authentification
    class SessionsController < Devise::SessionsController
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

      def after_sign_in_path_for(_resource)
        session[:previous_url] || admin_account_dashboards_path
      end
    end
  end
end
