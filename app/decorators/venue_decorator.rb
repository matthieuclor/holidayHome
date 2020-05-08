# frozen_string_literal: true

class VenueDecorator < ApplicationDecorator
  def beddings_count
    single_beds_count + (double_beds_count * 2)
  end

  def is_editable?
    return true if editable_for_others
    creator_id == current_user&.id
  end
end
