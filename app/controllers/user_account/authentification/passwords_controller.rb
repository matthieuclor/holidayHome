# frozen_string_literal: true

module UserAccount
  module Authentification
    class PasswordsController < Devise::PasswordsController
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

      protected

      def after_resetting_password_path_for(resource) # rubocop:disable Lint/UselessMethodDefinition
        super(resource)
      end

      # The path used after sending reset password instructions
      def after_sending_reset_password_instructions_path_for(resource_name) # rubocop:disable Lint/UselessMethodDefinition
        super(resource_name)
      end
    end
  end
end
