# frozen_string_literal: true

module AdminAccount
  class VehicleTypesController < AdminAccount::ApplicationController
    respond_to :js, :html
    before_action :vehicle_type, only: %i(edit update destroy)

    def index
      @query = VehicleType.ransack(vehicle_type_ransack_params)
      @pagy, @vehicle_types = pagy(@query.result)
    end

    def new
      @vehicle_type = VehicleType.new
    end

    def edit
    end

    def create
      @vehicle_type = VehicleType.new(vehicle_type_params)

      if @vehicle_type.save
        flash[:success] = t('.success')
        render js: 'location.reload()'
      else
        flash[:error] = t('.error')
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @vehicle_type.update(vehicle_type_params)
        flash[:success] = t('.success')
        render js: 'location.reload()'
      else
        flash[:error] = t('.error')
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if @vehicle_type.destroy
        flash[:success] = t('.success')
      else
        flash[:error] = t('.error')
      end

      redirect_to admin_account_vehicle_types_path
    end

    private

    def vehicle_type
      @vehicle_type ||= VehicleType.find(params[:id])
    end

    def vehicle_type_ransack_params
      @vehicle_type_ransack_params ||= params[:q]&.permit(:name_i_cont)
    end

    def vehicle_type_params
      params.require(:vehicle_type).permit(:name, :icon_prefix, :icon_class)
    end
  end
end
