# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    title { Faker::Movies::StarWars.wookiee_sentence }
    slug { nil }
    status { 0 }
  end
end
