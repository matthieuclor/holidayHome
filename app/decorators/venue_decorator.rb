# frozen_string_literal: true

class VenueDecorator < ApplicationDecorator
  def beddings_count
    @beddings_count ||= single_beds_count + (double_beds_count * 2)
  end
end
