# frozen_string_literal: true

module CurrentVenue
  extend ActiveSupport::Concern

  included do
    def set_current_venue
      @current_venue = Venue.find_by(id: current_user.current_venue_id)

      unless @current_venue.present?
        if first_venue_id = current_user.venues.first&.id
          current_user.update(current_venue_id: first_venue_id)
          set_current_venue
        end
      end
    end
  end
end
