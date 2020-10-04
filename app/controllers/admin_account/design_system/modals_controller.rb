# frozen_string_literal: true

module AdminAccount
  module DesignSystem
    class ModalsController < AdminAccount::ApplicationController
      respond_to :js

      def create
        @modal_type = modal_params[:type]
      end

      private

      def modal_params
        params.require(:modal).permit(:type)
      end
    end
  end
end
