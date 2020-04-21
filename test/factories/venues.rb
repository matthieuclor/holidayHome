# frozen_string_literal: true

FactoryBot.define do
  factory :venue do
    name { Faker::Movies::HarryPotter.location }
    address { Faker::Address.full_address }
    with_network { [true, false].sample }
    with_digital_code { [true, false].sample }
    with_home_service { [true, false].sample }
    comment { Faker::Movies::HarryPotter.quote }
    editable_for_others { [true, false].sample }

    factory :venue_with_dependencies do
      after(:build) do |venue|
        venue.family = create(:family)
        venue.creator = create(:user)
      end
    end
  end
end
