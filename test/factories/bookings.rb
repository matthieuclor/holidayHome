# frozen_string_literal: true

FactoryBot.define do
  factory :booking do
    from { Faker::Date.forward(days: 7) }
    to { Faker::Date.forward(days: 14) }

    factory :booking_with_dependencies do
      after(:build) do |booking|
        booking.user = create(:user_with_families)
        booking.venue = create(
          :venue,
          { family: booking.user.families.first, creator: booking.user }
        )
      end
    end
  end
end
