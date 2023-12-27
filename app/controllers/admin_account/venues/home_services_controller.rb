# frozen_string_literal: true

module AdminAccount
  module Venues
    class HomeServicesController < AdminAccount::ApplicationController
      before_action :home_service

      def edit
      end

      def update
        if @home_service.update(home_service_params)
          flash[:success] = t('.success')
          render js: 'location.reload()'
        else
          flash[:error] = t('.error')
          render :edit
        end
      end

      private

      def home_service
        @home_service ||= HomeService.find_by(venue_id: params[:venue_id], id: params[:id])
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
