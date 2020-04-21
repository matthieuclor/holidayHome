# frozen_string_literal: true

FactoryBot.define do
  factory :key do
    name { Faker::House.room }

    factory :key_with_dependencies do
      after(:build) do |key|
        key.owner = create(:user)
      end
    end
  end
end
