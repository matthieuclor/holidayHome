# frozen_string_literal: true

module UserAccount
  class VehicleTypesController < UserAccount::ApplicationController
    respond_to :json

    def index
      @query = VehicleType.ransack(vehicle_type_ransack_params)
      @vehicle_types = @query.result.limit(5)
    end

    private

    def vehicle_type_ransack_params
      @vehicle_type_ransack_params ||= params[:q]&.permit(:name_i_cont)
    end
  end
end
