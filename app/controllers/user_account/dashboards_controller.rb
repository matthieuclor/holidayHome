# frozen_string_literal: true

module UserAccount
  class DashboardsController < UserAccount::ApplicationController
    include CurrentFamily, CurrentVenue

    before_action :set_current_family, :set_current_venue

    def index
      respond_to do |format|
        format.html
        format.json do
          @venues = @current_family.venues.with_attached_photos
        end
      end
    end
  end
end
