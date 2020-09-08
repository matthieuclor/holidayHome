# frozen_string_literal: true

module UserAccount
  module Venues
    class PhotosController < UserAccount::ApplicationController
      def create
        @venue = Venue.find(params[:venue_id])

        if @venue.photos.attach(photos_params[:photos])
          flash[:success] = "Les photos ont bien été enregistrés"
          render :create, status: :ok
        else
          flash[:error] = "Un problem est survenu lors de l'enregistrement des photos"
          render :create, status: :unprocessable_entity
        end
      end

      def destroy
        photo = ActiveStorage::Attachment.find_by(id: params[:id])

        if photo.present?
          photo.purge
          flash[:success] = "La photo a bien été supprimée"
          render :destroy, status: :ok
        else
          flash[:error] = "Un problem est survenu lors de la suppression de la photo"
          render :destroy, status: :unprocessable_entity
        end
      end

      private

      def photos_params
        params.require(:venue).permit(photos: [])
      end
    end
  end
end
