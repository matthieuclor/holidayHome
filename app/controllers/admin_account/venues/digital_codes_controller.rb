# frozen_string_literal: true

module AdminAccount
  module Venues
    class DigitalCodesController < AdminAccount::ApplicationController
      before_action :digital_code

      def edit
      end

      def update
        if @digital_code.update(digital_code_params)
          flash[:success] = t('.success')
          render js: 'location.reload()'
        else
          flash[:error] = t('.error')
          render :edit
        end
      end

      private

      def digital_code
        @digital_code ||= DigitalCode.find_by(venue_id: params[:venue_id], id: params[:id])
      end

      def digital_code_params
        params.require(:digital_code).permit(:name, :password)
      end
    end
  end
end
