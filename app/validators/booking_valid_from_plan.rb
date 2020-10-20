# frozen_string_literal: true

class BookingValidFromPlan < ActiveModel::Validator
  def validate(booking)
    return if booking.family&.users&.any? { |user| user.premium? }
    return if booking.venue == booking.user&.families&.first&.venues&.first

    booking.errors[:plan] << "Votre plan actuel ne permet pas de créer ou de modifier cette réservation"
  end
end
