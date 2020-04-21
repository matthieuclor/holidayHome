# frozen_string_literal: true

FactoryBot.define do
  factory :home_service do
    name { Faker::Job.title }
    person_in_charge { Faker::Movies::BackToTheFuture.character }
    address { Faker::Address.full_address }
    phone { Faker::PhoneNumber.cell_phone }
    email { Faker::Internet.email }
  end
end
