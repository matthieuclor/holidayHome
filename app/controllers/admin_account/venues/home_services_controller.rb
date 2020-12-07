# frozen_string_literal: true

module AdminAccount
  module Venues
    class HomeServicesController < AdminAccount::ApplicationController
      before_action :set_home_service

      def edit
      end

      def update
        if @home_service.update(home_service_params)
          flash[:success] = 'Le service à domicile a bien été mise à jour'
          render js: 'location.reload()'
        else
          flash[:error] = 'Un problem est survenu lors de la mise à jour du service à domicile'
          render :edit
        end
      end

      private

      def set_home_service
        @home_service = HomeService.find_by(venue_id: params[:venue_id], id: params[:id])
      end

      def home_service_params
        params.require(:home_service).permit(
          :name,
          :person_in_charge,
          :address,
          :phone,
          :email
        )
      end
    end
  end
end
