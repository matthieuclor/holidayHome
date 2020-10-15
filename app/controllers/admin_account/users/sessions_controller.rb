# frozen_string_literal: true

module AdminAccount
  module Users
    class SessionsController < AdminAccount::ApplicationController
      def create
        user = User.find(params[:user_id])
        sign_in(:user, user)
        redirect_to user_account_dashboards_path
      end
    end
  end
end
