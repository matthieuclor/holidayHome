# frozen_string_literal: true

module AdminAccount
  module Families
    class VenuesController < AdminAccount::ApplicationController
      respond_to :js

      def index
        @pagy, @venues = pagy(Venue.where(family_id: params[:family_id]))
      end
    end
  end
end
