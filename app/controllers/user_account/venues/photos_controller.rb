# frozen_string_literal: true

module UserAccount
  module Venues
    class PhotosController < UserAccount::ApplicationController
      def destroy
        photo = ActiveStorage::Attachment.find_by(id: params[:id])

        if photo.present?
          photo.purge
          flash[:success] = "La photo a bien été supprimée"
          render :destroy, status: :ok
        else
          flash[:error] = "Un problem est survenu lors de la suppression de la photo."
          render :destroy, status: :unprocessable_entity
        end
      end
    end
  end
end
