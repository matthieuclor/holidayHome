# frozen_string_literal: true

FactoryBot.define do
  factory :family do
    name { Faker::Name.last_name }
    days_for_approval {
      rand(Family::MIN_DAYS_FOR_APPROVAL..Family::MAX_DAYS_FOR_APPROVAL)
    }

    factory :family_with_dependencies do
      after(:build) do |family|
        family.creator = create(:user)
      end
    end
  end
end
