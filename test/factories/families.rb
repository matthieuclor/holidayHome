# frozen_string_literal: true

FactoryBot.define do
  factory :family do
    name { Faker::Name.last_name }
    days_for_approval do
      rand(Family::MIN_DAYS_FOR_APPROVAL..Family::MAX_DAYS_FOR_APPROVAL)
    end
  end
end
