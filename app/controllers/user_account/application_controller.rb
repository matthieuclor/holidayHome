# frozen_string_literal: true

module UserAccount
  class ApplicationController < ActionController::Base
    layout "user_account/layouts/application"

    before_action :authenticate_user!
    # before_action :check_user_achievement

    private

    def check_user_achievement
      return if current_user.venue_created?
      return if current_user.family_created?

      case current_user.step
        when "account_created"
          redirect_to user_account_families_path unless controller_name == "families"
        when "family_created"
          redirect_to user_account_families_path unless controller_name == "venues"
      end
    end
  end
end
