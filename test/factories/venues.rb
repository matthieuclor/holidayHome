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
    bedrooms_count { Faker::Number.non_zero_digit }
    bathrooms_count { Faker::Number.non_zero_digit }
    single_beds_count { Faker::Number.non_zero_digit }
    double_beds_count { Faker::Number.non_zero_digit }
    baby_beds_count { Faker::Number.non_zero_digit }
  end
end
