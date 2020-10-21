# frozen_string_literal: true

FactoryBot.define do
  password = Faker::Internet.password(min_length: 8, max_length: 128)

  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.cell_phone }
    address { Faker::Address.full_address }
    password { password }
    password_confirmation { password }
    confirmed_at { Date.today }
    plan { 0 }
    plan_deadline { nil }
  end
end
