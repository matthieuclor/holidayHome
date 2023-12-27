# frozen_string_literal: true

module AdminAccount
  module Venues
    class NetworksController < AdminAccount::ApplicationController
      before_action :network

      def edit
      end

      def update
        if @network.update(network_params)
          flash[:success] = t('.success')
          render js: 'location.reload()'
        else
          flash[:error] = t('.error')
          render :edit
        end
      end

      private

      def network
        @network ||= Network.find_by(venue_id: params[:venue_id], id: params[:id])
      end

      def network_params
        params.require(:network).permit(:name, :password)
      end
    end
  end
end
