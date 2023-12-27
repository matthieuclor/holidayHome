# frozen_string_literal: true

module AdminAccount
  module Venues
    class VehiclesController < AdminAccount::ApplicationController
      before_action :vehicle

      def edit
      end

      def update
        if @vehicle.update(vehicle_params)
          flash[:success] = t('.success')
          render js: 'location.reload()'
        else
          flash[:error] = t('.error')
          render :edit
        end
      end

      private

      def vehicle
        @vehicle ||= Vehicle.find_by(venue_id: params[:venue_id], id: params[:id])
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
