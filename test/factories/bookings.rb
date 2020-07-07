# frozen_string_literal: true

FactoryBot.define do
  factory :booking do
    from { Faker::Date.forward(days: 7) }
    to { Faker::Date.forward(days: 14) }
  end
end
