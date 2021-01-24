# frozen_string_literal: true

module Api
  module Authentification
    class SessionsController < Api::ApplicationController
      skip_before_action :process_token, :authenticate_user!

      def create
        @user = User.find_by(email: user_params[:email])

        if @user&.valid_password?(user_params[:password])
          @jwt_token = @user.generate_jwt
        else
          head :unauthorized
        end
      end

      private

      def user_params
        params.require(:user).permit(:email, :password)
      end
    end
  end
end
