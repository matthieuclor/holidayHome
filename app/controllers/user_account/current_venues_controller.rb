# frozen_string_literal: true

module UserAccount
  class CurrentVenuesController < UserAccount::ApplicationController
    include CurrentVenue

    def update
      if current_user.update(current_venue_id: current_venue_params[:id])
        set_current_venue
        render :update, status: :ok
      else
        flash[:error] = "Un problem est survenu lors de la sélection du lieu"
        render :update, status: :unprocessable_entity
      end
    end

    private

    def current_venue_params
      params.require(:current_venue).permit(:id)
    end
  end
end
