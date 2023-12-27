# frozen_string_literal: true

module AdminAccount
  module Venues
    class PhotosController < AdminAccount::ApplicationController
      before_action :venue

      def create
        if @venue.photos.attach(photos_params[:photos])
          flash[:success] = t('.success')
        else
          flash[:error] = t('.error')
        end

        redirect_to admin_account_venue_path(params[:venue_id])
      end

      def destroy
        photo = @venue.photos.find(id: params[:id])

        if photo.present?
          photo.purge
          flash[:success] = t('.success')
        else
          flash[:error] = t('.error')
        end

        redirect_to admin_account_venue_path(params[:venue_id])
      end

      private

      def venue
        @venue ||= Venue.find(params[:venue_id])
      end

      def photos_params
        params.require(:venue).permit(photos: [])
      end
    end
  end
end
