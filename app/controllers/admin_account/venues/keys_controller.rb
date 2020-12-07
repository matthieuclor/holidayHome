# frozen_string_literal: true

module AdminAccount
  module Venues
    class KeysController < AdminAccount::ApplicationController
      before_action :set_key

      def edit
      end

      def update
        if @key.update(key_params)
          flash[:success] = 'La clé a bien été mise à jour'
          render js: 'location.reload()'
        else
          flash[:error] = 'Un problem est survenu lors de la mise à jour de la clé'
          render :edit
        end
      end

      private

      def set_key
        @key = Key.find_by(venue_id: params[:venue_id], id: params[:id])
      end

      def key_params
        params.require(:key).permit(:name, :owner_id)
      end
    end
  end
end
