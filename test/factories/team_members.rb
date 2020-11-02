# frozen_string_literal: true

FactoryBot.define do
  factory :team_member do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    function { Faker::Company.profession }
    status { 0 }
  end
end
