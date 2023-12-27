# frozen_string_literal: true

module AdminAccount
  module Venues
    class KeysController < AdminAccount::ApplicationController
      before_action :key

      def edit
      end

      def update
        if @key.update(key_params)
          flash[:success] = t('.success')
          render js: 'location.reload()'
        else
          flash[:error] = t('.error')
          render :edit
        end
      end

      private

      def key
        @key ||= Key.find_by(venue_id: params[:venue_id], id: params[:id])
      end

      def key_params
        params.require(:key).permit(:name, :owner_id)
      end
    end
  end
end
