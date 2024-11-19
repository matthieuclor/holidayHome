# frozen_string_literal: true

module UserAccount
  module Venues
    class PhotosController < UserAccount::ApplicationController
      before_action :set_venue

      def create
        if @venue.photos.attach(photos_params[:photos])
          flash[:success] = t('.success')
          render status: :created
        else
          flash[:error] = t('.error')
          render status: :unprocessable_entity
        end
      end

      def destroy
        photo = @venue.photos.find(id: params[:id])

        if photo.present?
          photo.purge
          flash[:success] = t('.success')
          render status: :ok
        else
          flash[:error] = t('.error')
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
