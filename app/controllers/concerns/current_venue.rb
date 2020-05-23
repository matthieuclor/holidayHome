# frozen_string_literal: true

module CurrentVenue
  extend ActiveSupport::Concern

  included do
    def set_current_venue
      @current_venue = Venue.find_by(
        id: current_user.current_venue_id[current_user.current_family_id.to_s].to_s
      )

      unless @current_venue.present?
        first_venue_id = Family.find_by(
          id: current_user.current_family_id
        )&.venues&.first&.id

        if first_venue_id
          current_user.current_venue_id[current_user.current_family_id.to_s] = first_venue_id
          set_current_venue if current_user.save
        end
      end
    end
  end
end
