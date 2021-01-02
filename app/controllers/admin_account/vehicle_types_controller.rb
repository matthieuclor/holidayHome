# frozen_string_literal: true

module AdminAccount
  class VehicleTypesController < AdminAccount::ApplicationController
    respond_to :js, :html
    before_action :set_vehicle_type, only: %i(edit update destroy)

    def index
      @query = VehicleType.ransack(vehicle_type_ransack_params)
      @pagy, @vehicle_types = pagy(@query.result)
    end

    def new
      @vehicle_type = VehicleType.new
    end

    def create
      @vehicle_type = VehicleType.new(vehicle_type_params)

      if @vehicle_type.save
        flash[:success] = 'Le type de véhicule a bien été créé'
        render js: 'location.reload()'
      else
        flash[:error] = 'Un problem est survenu lors de la création du type de véhicule'
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @vehicle_type.update(vehicle_type_params)
        flash[:success] = 'Le type de véhicule a bien été mise à jour'
        render js: 'location.reload()'
      else
        flash[:error] = 'Un problem est survenu lors de la mise à jour du type de véhicule'
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if @vehicle_type.destroy
        flash[:success] = 'Le type de véhicule a bien été supprimé'
      else
        flash[:error] = 'Un problem est survenu lors de la suppression du type de véhicule'
      end

      redirect_to admin_account_vehicle_types_path
    end

    private

    def set_vehicle_type
      @vehicle_type = VehicleType.find(params[:id])
    end

    def vehicle_type_ransack_params
      @vehicle_type_ransack_params ||= params[:q]&.permit(:name_cont)
    end

    def vehicle_type_params
      params.require(:vehicle_type).permit(:name, :icon_prefix, :icon_class)
    end
  end
end
