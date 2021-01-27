# frozen_string_literal: true

module Api
  class CurrentFamiliesController < Api::ApplicationController
    def update
      current_user.update(current_family_id: current_family_params[:id])
    end

    private

    def current_family_params
      params.require(:current_family).permit(:id)
    end
  end
end
