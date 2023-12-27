# frozen_string_literal: true

module AdminAccount
  module Users
    class EmailConfirmationsController < AdminAccount::ApplicationController
      def update
        user = User.find(params[:user_id])

        if user.confirm
          flash[:success] = t('.success', { first_name: user.first_name })
        else
          flash[:error] = t('.error')
        end

        redirect_back fallback_location: admin_account_users_path
      end
    end
  end
end
