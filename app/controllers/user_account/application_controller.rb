# frozen_string_literal: true

module UserAccount
  class ApplicationController < ActionController::Base
    layout "user_account/layouts/application"

    before_action :authenticate_user!
    before_action :check_family_and_venue

    private

    def check_family_and_venue
      if current_user.current_family_id.present?
        if controller_name != "venues" && !current_user.current_venue_id.present?
          redirect_to user_account_venues_path
        end
      else
        redirect_to user_account_families_path unless controller_name == "families"
      end
    end
  end
end
