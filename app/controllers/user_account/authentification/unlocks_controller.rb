# frozen_string_literal: true

module UserAccount
  module Authentification
    class UnlocksController < Devise::UnlocksController
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

      # The path used after sending unlock password instructions
      def after_sending_unlock_instructions_path_for(resource) # rubocop:disable Lint/UselessMethodDefinition
        super(resource)
      end

      # The path used after unlocking the resource
      def after_unlock_path_for(resource) # rubocop:disable Lint/UselessMethodDefinition
        super(resource)
      end
    end
  end
end
