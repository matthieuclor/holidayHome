# frozen_string_literal: true

module AdminAccount
  module Venues
    class PhotosController < AdminAccount::ApplicationController
      before_action :set_venue

      def create
        if @venue.photos.attach(photos_params[:photos])
          flash[:success] = 'Les photos ont bien été enregistrés'
        else
          flash[:error] = "Un problem est survenu lors de l'enregistrement des photos"
        end

        redirect_to admin_account_venue_path(params[:venue_id])
      end

      def destroy
        photo = @venue.photos.find(id: params[:id])

        if photo.present?
          photo.purge
          flash[:success] = 'La photo a bien été supprimée'
        else
          flash[:error] = 'Un problem est survenu lors de la suppression de la photo'
        end

        redirect_to admin_account_venue_path(params[:venue_id])
      end

      private

      def set_venue
        @venue = Venue.find(params[:venue_id])
      end

      def photos_params
        params.require(:venue).permit(photos: [])
      end
    end
  end
end
