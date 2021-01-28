# frozen_string_literal: true

module Api
  class CurrentFamiliesController < Api::ApplicationController
    def update
      if current_user.update(current_family_id: current_family_params[:id])
        render status: :ok
      else
        head :unprocessable_entity
      end
    end

    private

    def current_family_params
      params.require(:current_family).permit(:id)
    end
  end
end
