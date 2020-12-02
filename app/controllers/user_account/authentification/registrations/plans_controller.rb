# frozen_string_literal: true

module UserAccount
  module Authentification
    module Registrations
      class PlansController < ::ApplicationController
        def create
          session[:hutoki_plan] = plan_params[:plan]
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
