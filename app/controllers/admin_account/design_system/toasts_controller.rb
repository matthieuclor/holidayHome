# frozen_string_literal: true

module AdminAccount
  module DesignSystem
    class ToastsController < AdminAccount::ApplicationController
      respond_to :js

      def create
        flash[toast_params[:type].to_sym] = "Voici un toast de type #{toast_params[:type]} !"
      end

      private

      def toast_params
        params.require(:toast).permit(:type)
      end
    end
  end
end
