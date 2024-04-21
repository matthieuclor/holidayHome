# frozen_string_literal: true

module UserAccount
  module Venues
    class VehiclesController < UserAccount::ApplicationController
      respond_to :json
      before_action :set_venue
      before_action :set_vehicle, only: %i(edit update destroy)

      def index
        @vehicles = Vehicle.where(venue_id: @venue.id)
                           .order(:vehicle_type, :condition, :created_at)
      end

      def new
        @vehicle = @venue.vehicles.build
      end

      def edit
      end

      def create
        @vehicle = Vehicle.new(vehicles_params)

        if @vehicle.save
          flash[:success] = t('.success')
          render :create, status: :created
        else
          flash[:error] = t('.error')
          render :new, status: :unprocessable_entity
        end
      end

      def update
        if @vehicle.update(vehicles_params)
          flash[:success] = t('.success')
          render :update, status: :ok
        else
          flash[:error] = t('.error')
          render :edit, status: :unprocessable_entity
        end
      end

      def destroy
        if @vehicle.destroy
          flash[:success] = t('.success')
          render status: :ok
        else
          flash[:error] = t('.error')
          render status: :unprocessable_entity
        end
      end

      private

      def set_venue
        @venue = Venue.find(params[:venue_id])
      end

      def set_vehicle
        @vehicle = Vehicle.find_by(venue_id: @venue.id, id: params[:id])
      end

      def vehicles_params
        params.require(:vehicle).permit(
          :venue_id,
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
