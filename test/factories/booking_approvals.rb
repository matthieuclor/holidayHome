# frozen_string_literal: true

FactoryBot.define do
  factory :booking_approval do
    user { create(:user_with_families) }
    booking { create(:booking_with_dependencies) }
  end
end
