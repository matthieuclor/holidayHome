# frozen_string_literal: true

module Api
  class ApplicationController < ActionController::Base
    include Pagy::Backend

    layout false
    respond_to :json
    skip_before_action :verify_authenticity_token
    before_action :process_token, :authenticate_user!

    def current_user
      @current_user ||= User.find(@current_user_id)
    end

    private

    def authenticate_user!
      head :unauthorized unless signed_in?
    end

    def signed_in?
      @current_user_id.present?
    end

    def process_token
      return unless request.headers['Authorization'].present?

      begin
        jwt_payload =
          JWT.decode(
            request.headers['Authorization'],
            Rails.application.secret_key_base
          ).first

        @current_user_id = jwt_payload['id']
      rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
        head :unauthorized
      end
    end
  end
end
