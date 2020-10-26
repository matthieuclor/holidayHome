# frozen_string_literal: true

module UserAccount
  module Authentification
    module Registrations
      class PlansController < ActionController::Base
        def create
          cookies[:hutoki_plan] = {
            value: plan_params[:plan],
            expires: 1.day.from_now
          }

          redirect_to new_user_registration_path
        end

        private

        def plan_params
          params.require(:user).permit(:plan)
        end
      end
    end
  end
end
