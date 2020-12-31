# frozen_string_literal: true

module UserAccount
  module Venues
    class PhotosController < UserAccount::ApplicationController
      before_action :set_venue

      def create
        if @venue.photos.attach(photos_params[:photos])
          flash[:success] = 'Les photos ont bien été enregistrés'
          render status: :created
        else
          flash[:error] = "Un problem est survenu lors de l'enregistrement des photos"
          render status: :unprocessable_entity
        end
      end

      def destroy
        photo = @venue.photos.where(id: params[:id])

        if photo.present?
          photo.purge
          flash[:success] = 'La photo a bien été supprimée'
          render status: :ok
        else
          flash[:error] = 'Un problem est survenu lors de la suppression de la photo'
          render status: :unprocessable_entity
        end
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
