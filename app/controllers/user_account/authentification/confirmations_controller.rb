# frozen_string_literal: true

module UserAccount
  module Authentification
    class ConfirmationsController < Devise::ConfirmationsController
      def new # rubocop:disable Lint/UselessMethodDefinition
        super
      end

      def create # rubocop:disable Lint/UselessMethodDefinition
        super
      end

      def show # rubocop:disable Lint/UselessMethodDefinition
        super
      end

      protected

      # The path used after resending confirmation instructions.
      def after_resending_confirmation_instructions_path_for(resource_name) # rubocop:disable Lint/UselessMethodDefinition
        super(resource_name)
      end

      # The path used after confirmation.
      def after_confirmation_path_for(resource_name, resource) # rubocop:disable Lint/UselessMethodDefinition
        super(resource_name, resource)
      end
    end
  end
end
