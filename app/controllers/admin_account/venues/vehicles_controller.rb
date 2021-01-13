# frozen_string_literal: true

module AdminAccount
  module Venues
    class VehiclesController < AdminAccount::ApplicationController
      before_action :set_vehicle

      def edit
      end

      def update
        if @vehicle.update(vehicle_params)
          flash[:success] = 'Le véhicule a bien été mise à jour'
          render js: 'location.reload()'
        else
          flash[:error] = 'Un problem est survenu lors de la mise à jour du véhicule'
          render :edit
        end
      end

      private

      def set_vehicle
        @vehicle = Vehicle.find_by(venue_id: params[:venue_id], id: params[:id])
      end

      def vehicle_params
        params.require(:vehicle).permit(
          :vehicle_type,
          :name,
          :size,
          :condition,
          :comment
        )
      end
    end
  end
end
