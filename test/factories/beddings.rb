# frozen_string_literal: true

FactoryBot.define do
  factory :bedding do
    bed_type { Bedding.bed_types.keys.sample }
    bed_count { Faker::Number.within(range: 1..10) }
  end
end
