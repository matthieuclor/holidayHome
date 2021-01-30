# frozen_string_literal: true

module Api
  class CurrentVenuesController < Api::ApplicationController
    include CurrentVenue

    def update
      current_user.current_venue_id[current_user.current_family_id.to_s] = current_venue_params[:id]

      if current_user.save
        set_current_venue
        render status: :ok
      else
        head :unprocessable_entity
      end
    end

    private

    def current_venue_params
      params.require(:current_venue).permit(:id)
    end
  end
end
