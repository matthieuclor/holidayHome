# frozen_string_literal: true

class VenueValidFromPlan < ActiveModel::Validator
  def validate(venue)
    return if venue.family.premium?
    return if venue.creator.families.first == venue.family &&
      venue.family.venues.count < User::PLAN_BASIC_LIMIT[:families_venues]

    venue.errors.add(:base, :plan_basic_limit)
  end
end
