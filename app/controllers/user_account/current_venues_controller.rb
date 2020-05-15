# frozen_string_literal: true

module UserAccount
  class CurrentVenuesController < UserAccount::ApplicationController
    def update
      if current_user.update(current_venue_id: current_venue_params[:id])
        flash[:success] = "Le lieu a bien été sélectionné"
      else
        flash[:error] = "Un problem est survenu lors de la sélection du lieu"
      end
    end

    private

    def current_venue_params
      params.require(:current_venue).permit(:id)
    end
  end
end
