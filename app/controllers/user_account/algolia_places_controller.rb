# frozen_string_literal: true

module UserAccount
  class AlgoliaPlacesController < UserAccount::ApplicationController
    respond_to :json

    def create
      @algolia_places = AlgoliaPlaces.new(
        query: algolia_places_params[:query]
      ).call

      if @algolia_places.error.present?
        render :create, status: :unprocessable_entity
      else
        render :create, status: :ok
      end
    end

    private

    def algolia_places_params
      params.require(:algolia_places).permit(:query)
    end
  end
end
