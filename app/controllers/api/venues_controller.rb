# frozen_string_literal: true

module Api
  class VenuesController < Api::ApplicationController
    def index
      @venues = VenueDecorator.wrap(
        current_user.current_family.venues.with_attached_photos
      )
    end
  end
end
