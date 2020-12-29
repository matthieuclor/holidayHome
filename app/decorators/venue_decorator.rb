# frozen_string_literal: true

class VenueDecorator < ApplicationDecorator
  def beddings_count
    @beddings_count ||=
      single_beds_count +
      (double_beds_count * 2) +
      single_sofa_beds_count +
      (double_sofa_beds_count * 2)
  end

  def map_link
    @map_link ||=
      if lat && lng
        "#{Venue::GOOGLE_MAP_SEARCH_URL}?api=1&query=#{lat},#{lng}"
      else
        '#'
      end
  end
end
