# frozen_string_literal: true

module UserAccount
  class AlgoliaPlacesController < UserAccount::ApplicationController
    respond_to :json

    def create
      @algolia_places = AlgoliaPlaces.call(query: algolia_places_params[:query])

      if @algolia_places.error.present?
        render status: :unprocessable_entity
      else
        render status: :ok
      end
    end

    private

    def algolia_places_params
      params.require(:algolia_places).permit(:query)
    end
  end
end
