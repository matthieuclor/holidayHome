# frozen_string_literal: true

module UserAccount
  class CurrentVenuesController < UserAccount::ApplicationController
    respond_to :json
    include CurrentVenue

    def update
      current_user.current_venue_id[current_user.current_family_id.to_s] = current_venue_params[:id]

      if current_user.save
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
