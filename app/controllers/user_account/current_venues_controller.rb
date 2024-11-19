# frozen_string_literal: true

module UserAccount
  class CurrentVenuesController < UserAccount::ApplicationController
    include CurrentVenue
    respond_to :json

    def update
      current_user.current_venue_id[current_user.current_family_id.to_s] = current_venue_params[:id]

      if current_user.save
        set_current_venue
        render status: :ok
      else
        flash[:error] = t('.error')
        render status: :unprocessable_entity
      end
    end

    private

    def current_venue_params
      params.require(:current_venue).permit(:id)
    end
  end
end
