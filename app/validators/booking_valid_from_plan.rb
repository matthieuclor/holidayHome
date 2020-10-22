# frozen_string_literal: true

class BookingValidFromPlan < ActiveModel::Validator
  def validate(booking)
    return if booking.family.users.any? { |user| user.premium? }
    return if booking.venue == booking.user.families.first.venues.first

    booking.errors.add(:base, :plan_basic_limit)
  end
end
