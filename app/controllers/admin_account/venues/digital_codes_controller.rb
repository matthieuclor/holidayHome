# frozen_string_literal: true

module AdminAccount
  module Venues
    class DigitalCodesController < AdminAccount::ApplicationController
      before_action :set_digital_code

      def edit
      end

      def update
        if @digital_code.update(digital_code_params)
          flash[:success] = 'Le digicode a bien été mise à jour'
          render js: 'location.reload()'
        else
          flash[:error] = 'Un problem est survenu lors de la mise à jour du digicode'
          render :edit
        end
      end

      private

      def set_digital_code
        @digital_code = DigitalCode.find_by(venue_id: params[:venue_id], id: params[:id])
      end

      def digital_code_params
        params.require(:digital_code).permit(:name, :password)
      end
    end
  end
end
