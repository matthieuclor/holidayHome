# frozen_string_literal: true

module UserAccount
  class CurrentVenuesController < UserAccount::ApplicationController
    def update
      current_user.update(current_venue_id: current_venue_params[:id])
      redirect_back fallback_location: user_account_dashboards_path
    end

    private

    def current_venue_params
      params.require(:current_venue).permit(:id)
    end
  end
end
