# frozen_string_literal: true

module AdminAccount
  module Venues
    class NetworksController < AdminAccount::ApplicationController
      before_action :set_network

      def edit
      end

      def update
        if @network.update(network_params)
          flash[:success] = 'Le réseau a bien été mise à jour'
          render js: 'location.reload()'
        else
          flash[:error] = 'Un problem est survenu lors de la mise à jour du réseau'
          render :edit
        end
      end

      private

      def set_network
        @network = Network.find_by(venue_id: params[:venue_id], id: params[:id])
      end

      def network_params
        params.require(:network).permit(:name, :password)
      end
    end
  end
end
